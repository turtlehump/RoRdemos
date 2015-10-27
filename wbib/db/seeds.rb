topics = Topic.create(
  [
    { title: 'Computers', description: 'Hardware, Software, Malware, Everything!'},
    { title: '2016 Election', description: 'Everything You need to know about the canidates of the 2016 US Presidential Election'}
  ]
)

references = Reference.create(
  [
    { URL: 'http://www.newegg.com', topic_id: topics[0].id},
    { URL: 'http://www.ecst.csuchico.edu/~tyson', topic_id: topics[0].id},
    { URL: 'http://www.cnn.com', topic_id: topics[1].id}
  ]
)
