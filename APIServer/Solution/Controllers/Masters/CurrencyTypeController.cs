﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Solution.Services.MasterData;
using Common;
using Solution.DataDefinitions.Entities;
using Solution.DataDefinitions.Models;
using NHibernate.Criterion;
using Solution.Exceptions;

namespace Solution.Controllers.Masters
{
    [Authorize]
    [Route("api/masterdata/[controller]")]
    [ApiController]
    public class CurrencyTypeController : BaseController
    {
        private IMapper _mapper;

        public CurrencyTypeController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            return new ControllerHelper<Currency, CurrencyModel>(this, _mapper).GetAll();
        }

    }
}