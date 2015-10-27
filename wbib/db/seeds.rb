topics = Topic.create(
  [
    { title: 'Computers', description: 'Hardware, Software, Malware, Everything!'},
    { title: '2016 Election', description: 'Everything You need to know about the canidates of the 2016 US Presidential Election'},
    { title: 'Porn', description: 'If you need a description, I dont think you should be here...'},
    { title: 'Food', description: 'Only the best recipies can be put here'}
  ]
)

references = Reference.create(
  [
    { URL: 'http://www.newegg.com', topic_id: topics[0].id},
    { URL: 'http://www.ecst.csuchico.edu/~tyson', topic_id: topics[0].id},
    { URL: 'http://www.cnn.com', topic_id: topics[1].id},
    { URL: 'http://www.fox.com', topic_id: topics[1].id},
    { URL: 'http://www.youporn.com', topic_id: topics[2].id},
    { URL: 'http://www.pornhub.com', topic_id: topics[2].id},
    { URL: 'http://www.mrskin.com', topic_id: topics[2].id},
    { URL: 'http://www.xxx.com', topic_id: topics[2].id},
    { URL: 'http://www.macheesmo.com/cast-iron-mac-and-cheese/', topic_id: topics[3].id},
    { URL: 'http://www.food.com/recipe/beths-melt-in-your-mouth-barbecue-ribs-oven-107786', topic_id: topics[3].id},
    { URL: 'http://www.cookinglight.com/food/top-rated-recipes/best-dessert-recipes', topic_id: topics[3].id}
  ]
)
