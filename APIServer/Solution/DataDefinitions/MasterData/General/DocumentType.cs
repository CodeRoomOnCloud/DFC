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
        public class DocumentTypeModel : BasicModel
        {
        }
    }

    namespace Entities
    {
        public class DocumentType : Basic
        {
        }
    }

    namespace DbMappings
    {
        public class DocumentTypeMap : ClassMap<DocumentType>
        {
            public DocumentTypeMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Table("DocumentTypes");
            }
        }
    }

    namespace AutoMappings
    {
        public class DocumentTypeMapperProfile : MappingProfileBase
        {
            public DocumentTypeMapperProfile()
            {
                CreateBidirectionalMap<DocumentTypeModel, DocumentType>(true);
            }
        }
    }

}
