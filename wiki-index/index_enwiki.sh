#! /bin/bash 

## adopted from https://www.elastic.co/blog/loading-wikipedia
# cirrus dumps (wiki dumps for ELK) can be obtained at https://dumps.wikimedia.org/other/cirrussearch/current/

export es=localhost:9200
export site=en.wikipedia.org
export dump=$1
if [ -z $dump ] ; then 
    echo "USAGE: pass me a cirrus dump file name (e.g. enwikiquote-20191223-cirrussearch-general.json.gz)"
export index=`echo $dump | cut -d '-' -f 1`

echo "# deleting existing index"
curl -XDELETE $es/$index?pretty

echo "# create a new index and PUT settings"
curl -H 'Content-Type: application/json' -s 'https://'$site'/w/api.php?action=cirrus-settings-dump&format=json&formatversion=2' |
  jq '{
    settings: { 
        index: { 
            analysis: .content.page.index.analysis, 
            similarity: .content.page.index.similarity 
        } 
    }
  }' |
      curl -H 'Content-Type: application/json' -XPUT $es/$index?pretty -d @-

echo "# now putting data types and mapping rules"
curl -H 'Content-Type: application/json' -s 'https://'$site'/w/api.php?action=cirrus-mapping-dump&format=json&formatversion=2' |
  jq .content |
  sed 's/"index_analyzer"/"analyzer"/' |
  sed 's/"position_offset_gap"/"position_increment_gap"/' |
  curl -H 'Content-Type: application/json' -XPUT $es/$index/_mapping/page?pretty -d @-

echo "# slicing large file for indexing"
if [ ! -d splits ] ; then 
    mkdir splits 
fi
cd splits
zcat ../$dump | split -a 10 -l 500 - $index
for file in * ; do 
    echo -n "${file}:  "
    took=$(curl -s -H 'Content-Type: application/x-ndjson' -XPOST $es/$index/_bulk?pretty --data-binary @$file |
        grep took | cut -d':' -f 2 | cut -d',' -f 1)
        printf '%7s\n' $took
done
