var express = require('express');
var router = express.Router();

var _ = require('lodash')
var nodesens = require('node-sens')

var userData= require('../data/user-data')
var userProfile = require('../data/user-profiles')

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/signIn', function(req, res, next) {
  var id = req.body.id
  var pw = req.body.pw
  console.log("id : " + id + " / pw: " + pw)
  
  var userD = _.cloneDeep(userData)
  var user = _.find(userD, function(object) { return object.userEmail == id && object.userPassword == pw})
  if (user == undefined) {
    res.status(404).send('Nothing Found');
  }
  res.json(user)
})


router.get('/auth/sms/:phone', async function(req, res, next) {
  var phone = req.params.phone

  var code = Math.floor(Math.random() * 10000) + 1
  
  const ncp = new nodesens.NCPClient({
      phoneNumber: '01075187260',
      serviceId: 'ncp:sms:kr:260158038916:pandasaza',
      secretKey: 'byszL5gtgauX6yRj4DCGHouGFp0HAH6atyQrDM50',
      accessKey: 'GCk1oT4Yu0SiByPg5rRN',
  });
  
  const { success, msg, status } = await ncp.sendSMS({
      to: phone,
      content: `[ PandaSaza ]\n Phone Validation Code ${code}`,
      countryCode: '82',
  });

  var response = {
      success: success,
      code: code,
      response: status,
  }

  console.log(phone)
  console.log(success, msg, status)

  res.json(response)
})

module.exports = router;
