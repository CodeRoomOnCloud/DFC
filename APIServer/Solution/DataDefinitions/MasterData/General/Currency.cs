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
        public class CurrencyModel : BasicModel
        {
        }
    }

    namespace Entities
    {
        public class Currency : Basic
        {
        }
    }

    namespace DbMappings
    {
        public class CurrencyMap : ClassMap<Currency>
        {
            public CurrencyMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Table("Currencies");
            }
        }
    }

    namespace AutoMappings
    {
        public class CurrencyMapperProfile : MappingProfileBase
        {
            public CurrencyMapperProfile()
            {
                CreateBidirectionalMap<CurrencyModel, Currency>(true);
            }
        }
    }

}
