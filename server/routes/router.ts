import express from "express";
const services = require('../services/render')
const route = express.Router()

route.get('/', (req,res) => res.send('oi'))
route.get('/a', (req,res) => res.send('a'))

route.get('/b', (req,res) => res.send('v'))

route.get('/c', services.homeRoutes)



module.exports = route;
