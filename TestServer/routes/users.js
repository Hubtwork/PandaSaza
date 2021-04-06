var express = require('express');
var router = express.Router();

var _ = require('lodash')

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

module.exports = router;
