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
        public class UnitModel : BasicModel
        {
        }
    }

    namespace Entities
    {
        public class Unit : Basic
        {
        }
    }

    namespace DbMappings
    {
        public class UnitMap : ClassMap<Unit>
        {
            public UnitMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Table("Units");
            }
        }
    }

    namespace AutoMappings
    {
        public class UnitMapperProfile : MappingProfileBase
        {
            public UnitMapperProfile()
            {
                CreateBidirectionalMap<UnitModel, Unit>(true);
            }
        }
    }
}
