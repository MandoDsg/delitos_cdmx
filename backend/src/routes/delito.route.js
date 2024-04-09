const { Router } = require('express');
const { consultardelitos} = require('../controllers/delito.controller')
const router = Router();

router.get('/api/delitos', consultardelitos);

module.exports = router;