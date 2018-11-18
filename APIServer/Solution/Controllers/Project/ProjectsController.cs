using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Solution.Services;
using Solution.DataDefinitions.Entities;
using Solution.DataDefinitions.Models;
using NHibernate.Criterion;
using Solution.Exceptions;
using Common;

namespace Solution.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ProjectsController : BaseController
    {
        private IMapper _mapper;

        public ProjectsController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            return new ControllerHelper<ProjectListItem, ProjectListItemModel>(this, _mapper).GetAll();
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            return new ControllerHelper<Project, ProjectModel>(this, _mapper).GetById(id);
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            return new ControllerHelper<Project, ProjectModel>(this, _mapper).Delete(id);
        }

        [HttpPost]
        public IActionResult Create([FromBody]ProjectModel itemDto)
        {
            return new ControllerHelper<Project, ProjectModel>(this, _mapper)
                .Create(itemDto, (session, item) =>
                {
                    var exists = session.CreateCriteria<Project>()
                        .Add(Restrictions.Eq("Name", item.Name)).List<Project>().Any();
                    if (exists)
                    {
                        throw new AppException($"Project name {item.Name} already exists!");
                    }
                    TrackCreation(item);
                }, (session, item) =>
                {
                    item = session.Get<Project>(item.ID);
                    return _mapper.Map<ProjectModel>(item);
                });
        }

        [HttpPost("review")]
        public IActionResult AddReview([FromBody]ProjectReviewModel itemDto)
        {
            return new ControllerHelper<ProjectReview, ProjectReviewModel>(this, _mapper)
                .Create(itemDto, (session, item) =>
                {
                    item.ReviewedBy = new User() { ID = HttpContext == null ? CurrentUserId : HttpContext.User.Identity.Name.ToInt() };
                    item.ReviewDateTime = DateTime.Now;
                }, (session, item) =>
                {
                    item = session.Get<ProjectReview>(item.ID);
                    return _mapper.Map<ProjectReviewModel>(item);
                });
        }

    }
}