using FluentNHibernate.Mapping;
using Solution.DataDefinitions.Entities;
using Solution.DataDefinitions.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Solution.DataDefinitions
{
    namespace Models
    {
        public class StatusModel : BasicModel
        {
            public virtual string AssociatedEntity { get; set; }
        }
    }

    namespace Entities
    {
        public class Status : Basic
        {
            public virtual string AssociatedEntity { get; set; }
        }
    }

    namespace DbMappings
    {
        public class StatusMap : ClassMap<Status>
        {
            public StatusMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Map(s => s.AssociatedEntity);
                Table("StatusCodes");
            }
        }
    }

    namespace AutoMappings
    {
        public class StatusMapperProfile : MappingProfileBase
        {
            public StatusMapperProfile()
            {
                CreateBidirectionalMap<StatusModel, Status>(true);
            }
        }
    }
}
