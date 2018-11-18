using AutoMapper;
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
        public class ProjectListItemModel : BasicModel
        {
            public virtual string ShortDescription { get; set; }
            public virtual DateTime StartDate { get; set; }
            public virtual DateTime? EndDate { get; set; }
            public virtual double TotalArea { get; set; }
            public virtual int NoOfUnits { get; set; }
            public virtual double BasePrice { get; set; }
            public virtual int BuyLimitMin { get; set; }
            public virtual int BuyLimitMax { get; set; }
            public virtual int SellLimitMin { get; set; }
            public virtual int SellLimitMax { get; set; }
            public virtual string Status { get; set; }
            public virtual string Unit { get; set; }
            public virtual string Currency { get; set; }
        }

        public class ProjectModel : BasicModel
        {
            public virtual string ShortDescription { get; set; }
            public virtual DateTime StartDate { get; set; }
            public virtual DateTime? EndDate { get; set; }

            public virtual double TotalArea { get; set; }
            public virtual int NoOfUnits { get; set; }
            public virtual double BasePrice { get; set; }

            public virtual int StatusID { get; set; }
            public virtual string Status { get; set; }

            public virtual int UnitID { get; set; }
            public virtual string Unit { get; set; }

            public virtual int CurrencyID { get; set; }
            public virtual string Currency { get; set; }

            public virtual ProjectTradeLimitModel TradeLimit { get; set; }
            public virtual ProjectContentModel Content { get; set; }
            public IList<ProjectReviewModel> Reviews { get; set; }
            public IList<ProjectDocumentModel> Documents { get; set; }
        }

        public class ProjectTradeLimitModel : BasicModel
        {
            public virtual int BuyLimitMin { get; set; }
            public virtual int BuyLimitMax { get; set; }
            public virtual int SellLimitMin { get; set; }
            public virtual int SellLimitMax { get; set; }
        }

        public class ProjectContentModel : BasicModel
        {
            public virtual string Content { get; set; }
        }

        public class ProjectReviewModel 
        {
            public virtual int ID { get; set; }
            public virtual string Remarks { get; set; }
            public virtual string Status { get; set; }
            public virtual int StatusID { get; set; }

            public virtual string ReviewedBy { get; set; }
            public virtual DateTime ReviewDateTime { get; set; }
        }

        public class ProjectDocumentModel : BasicModel
        {
            public int DocumentTypeID { get; set; }
            public string DocumentTypeName { get; set; }

            public string Description { get; set; }
            public string Remarks { get; set; }
            public string Location { get; set; }

            public bool IsAgentVisible { get; set; }
            public bool IsVendorVisible { get; set; }
            public bool IsCustomerVisible { get; set; }
            public bool IsPrivateVisible { get; set; }
        }
    }

    namespace Entities
    {
        public class ProjectListItem : Basic
        {
            public virtual string ShortDescription { get; set; }
            public virtual DateTime StartDate { get; set; }
            public virtual DateTime? EndDate { get; set; }

            public virtual double TotalArea { get; set; }
            public virtual int NoOfUnits { get; set; }
            public virtual double BasePrice { get; set; }

            public virtual int StatusID { get; set; }
            public virtual Status Status { get; set; }

            public virtual int UnitID { get; set; }
            public virtual Unit Unit { get; set; }

            public virtual int CurrencyID { get; set; }
            public virtual Currency Currency { get; set; }

            public virtual int TradeLimitID { get; set; }
            public virtual ProjectTradeLimit TradeLimit { get; set; }
        }

        public class Project : Basic
        {
            public virtual string ShortDescription { get; set; }
            public virtual DateTime StartDate { get; set; }
            public virtual DateTime? EndDate { get; set; }

            public virtual double TotalArea { get; set; }
            public virtual int NoOfUnits { get; set; }
            public virtual double BasePrice { get; set; }

            public virtual int StatusID { get; set; }
            public virtual Status Status { get; set; }

            public virtual int UnitID { get; set; }
            public virtual Unit Unit { get; set; }

            public virtual int CurrencyID { get; set; }
            public virtual Currency Currency { get; set; }

            public virtual int TradeLimitID { get; set; }
            public virtual ProjectTradeLimit TradeLimit { get; set; }

            public virtual int ContentID { get; set; }
            public virtual ProjectContent Content { get; set; }

            public virtual IList<ProjectReview> Reviews { get; set; }
            public virtual IList<ProjectDocument> Documents { get; set; }
        }

        public class ProjectTradeLimit : Basic
        {
            public virtual int BuyLimitMin { get; set; }
            public virtual int BuyLimitMax { get; set; }
            public virtual int SellLimitMin { get; set; }
            public virtual int SellLimitMax { get; set; }
        }

        public class ProjectContent : Basic 
        {
            public virtual string Content { get; set; }
        }

        public class ProjectDocument : Basic
        {
            public virtual string Location { get; set; }
            public virtual string Description { get; set; }
            public virtual string Remarks { get; set; }
            public virtual int DocumentTypeID { get; set; }
            public virtual DocumentType Type { get; set; }

            public virtual bool IsAgentVisible { get; set; }
            public virtual bool IsVendorVisible { get; set; }
            public virtual bool IsCustomerVisible { get; set; }
            public virtual bool IsPrivateVisible { get; set; }

            public virtual Project Project { get; set; }
        }

        public class ProjectReview
        {
            public virtual int ID { get; set; }
            public virtual string Remarks { get; set; }
            public virtual int StatusID { get; set; }
            public virtual Status Status { get; set; }

            public virtual User ReviewedBy { get; set; }
            public virtual int ReviewedByUserID { get; set; }
            public virtual DateTime ReviewDateTime { get; set; }

            public virtual Project Project { get; set; }

        }
    }

    namespace DbMappings
    {
        public class ProjectListItemMap : ClassMap<ProjectListItem>
        {
            public ProjectListItemMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Map(s => s.ShortDescription);
                Map(s => s.StartDate);
                Map(s => s.EndDate);
                Map(s => s.TotalArea);
                Map(s => s.NoOfUnits);
                Map(s => s.BasePrice);

                Map(s => s.Active);
                Table("Projects");

                References(s => s.TradeLimit, "TradeLimitID").Cascade.All();

                References(s => s.Status, "StatusID");
                References(s => s.Unit, "UnitID");
                References(s => s.Currency, "CurrencyID");

                Map(s => s.CreatedDateTime).Insert().Not.Update();
                Map(s => s.UpdatedDateTime).Not.Insert();
                References(s => s.CreatedBy, "CreatedByUserID").Insert().Not.Update();
                References(s => s.UpdatedBy, "UpdatedByUserID").Not.Insert();
            }
        }

        public class ProjectMap : ClassMap<Project>
        {
            public ProjectMap()
            {
                Id(s => s.ID);
                Map(s => s.Name);
                Map(s => s.ShortDescription);
                Map(s => s.StartDate);
                Map(s => s.EndDate);
                Map(s => s.TotalArea);
                Map(s => s.NoOfUnits);
                Map(s => s.BasePrice);

                Map(s => s.Active);
                Table("Projects");

                References(s => s.TradeLimit, "TradeLimitID").Cascade.All();
                References(s => s.Content, "ContentID").Cascade.All();

                References(s => s.Status, "StatusID");
                References(s => s.Unit, "UnitID");
                References(s => s.Currency, "CurrencyID");

                Map(s => s.CreatedDateTime).Insert().Not.Update();
                Map(s => s.UpdatedDateTime).Not.Insert();
                References(s => s.CreatedBy, "CreatedByUserID").Insert().Not.Update();
                References(s => s.UpdatedBy, "UpdatedByUserID").Not.Insert();

                HasMany(s => s.Documents)
                    .KeyColumn("ProjectID")
                    .Cascade.All();

                HasMany(s => s.Reviews)
                    .KeyColumn("ProjectID")
                    .Cascade.All();
            }
        }

        public class ProjectTradeLimitMap : ClassMap<ProjectTradeLimit>
        {
            public ProjectTradeLimitMap()
            {
                Id(s => s.ID);
                Map(s => s.BuyLimitMin);
                Map(s => s.SellLimitMin);
                Map(s => s.BuyLimitMax);
                Map(s => s.SellLimitMax);
                Map(s => s.UpdatedDateTime).Not.Insert();
                References(s => s.UpdatedBy, "UpdatedByUserID").Not.Insert();

                Table("ProjectTradeLimits");
            }
        }

        public class ProjectContentMap : ClassMap<ProjectContent>
        {
            public ProjectContentMap()
            {
                Id(s => s.ID);
                Map(s => s.Content);
                Map(s => s.UpdatedDateTime).Not.Insert();
                References(s => s.UpdatedBy, "UpdatedByUserID").Not.Insert();

                Table("ProjectContents");
            }
        }

        public class ProjectDocumentMap : ClassMap<ProjectDocument>
        {
            public ProjectDocumentMap()
            {
                Id(s => s.ID).UnsavedValue(0);
                Map(s => s.Name);
                Map(s => s.Location);
                Map(s => s.Description);
                Map(s => s.Remarks);
                Map(s => s.IsAgentVisible);
                Map(s => s.IsVendorVisible);
                Map(s => s.IsCustomerVisible);
                Map(s => s.IsPrivateVisible);
                Map(s => s.CreatedDateTime).Insert().Not.Update();
                Map(s => s.UpdatedDateTime).Not.Insert();

                Table("ProjectDocuments");

                References(s => s.Project, "ProjectID").Not.Insert().Not.Update();
                References(s => s.Type, "DocumentTypeID");
                References(s => s.CreatedBy, "CreatedByUserID").Insert().Not.Update();
                References(s => s.UpdatedBy, "UpdatedByUserID").Not.Insert();
            }
        }

        public class ProjectReviewMap : ClassMap<ProjectReview>
        {
            public ProjectReviewMap()
            {
                Id(s => s.ID).UnsavedValue(0);
                Map(s => s.Remarks);

                Table("ProjectReviews");

                References(s => s.Project, "ProjectID").Not.Insert().Not.Update();
                References(s => s.ReviewedBy, "ReviewedByUserID");
                References(s => s.Status, "StatusID");
            }
        }
    }

    namespace AutoMappings
    {
        public class ProjectMappingProfile : MappingProfileBase
        {
            public ProjectMappingProfile()
            {
                var map1 = CreateMap<ProjectListItem, ProjectListItemModel>(MemberList.None)
                     .ForMember(dest => dest.SellLimitMin,
                         opts => opts.MapFrom(src => src.TradeLimit.SellLimitMin))
                     .ForMember(dest => dest.BuyLimitMin,
                         opts => opts.MapFrom(src => src.TradeLimit.BuyLimitMin))
                     .ForMember(dest => dest.SellLimitMax,
                         opts => opts.MapFrom(src => src.TradeLimit.SellLimitMax))
                     .ForMember(dest => dest.BuyLimitMax,
                         opts => opts.MapFrom(src => src.TradeLimit.BuyLimitMax))
                     .ForMember(dest => dest.Status,
                         opts => opts.MapFrom(src => src.Status.Name))
                     .ForMember(dest => dest.Currency,
                         opts => opts.MapFrom(src => src.Currency.Name))
                     .ForMember(dest => dest.Unit,
                         opts => opts.MapFrom(src => src.Unit.Name));
                map1.ReverseMap();

                var map2 = CreateMap<ProjectReview, ProjectReviewModel>(MemberList.None)
                     .ForMember(dest => dest.ReviewedBy,
                         opts => opts.MapFrom(src => src.ReviewedBy.UserName))
                     .ForMember(dest => dest.StatusID,
                         opts => opts.MapFrom(src => src.Status.ID))
                     .ForMember(dest => dest.Status,
                         opts => opts.MapFrom(src => src.Status.Name));
                map2.ReverseMap();

                var map3 = CreateMap<ProjectDocument, ProjectDocumentModel>(MemberList.None)
                     .ForMember(dest => dest.DocumentTypeID,
                         opts => opts.MapFrom(src => src.Type.ID))
                     .ForMember(dest => dest.DocumentTypeName,
                         opts => opts.MapFrom(src => src.Type.Name));
                map3.ReverseMap();

                CreateBidirectionalMap<ProjectTradeLimit, ProjectTradeLimitModel>(false);
                CreateBidirectionalMap<ProjectContent, ProjectContentModel>(false);

                var map = CreateMap<Project, ProjectModel>(MemberList.None)
                     .ForMember(dest => dest.StatusID,
                         opts => opts.MapFrom(src => src.Status.ID))
                     .ForMember(dest => dest.Status,
                         opts => opts.MapFrom(src => src.Status.Name))
                     .ForMember(dest => dest.CurrencyID,
                         opts => opts.MapFrom(src => src.Currency.ID))
                     .ForMember(dest => dest.Currency,
                         opts => opts.MapFrom(src => src.Currency.Name))
                     .ForMember(dest => dest.UnitID,
                         opts => opts.MapFrom(src => src.Unit.ID))
                     .ForMember(dest => dest.Unit,
                         opts => opts.MapFrom(src => src.Unit.Name))

                     .ForMember(dest => dest.TradeLimit,
                         opts => opts.MapFrom(src => src.TradeLimit))

                     .ForMember(dest => dest.Content,
                         opts => opts.MapFrom(src => src.Content))

                     .ForMember(dest => dest.Documents,
                         opts => opts.MapFrom(src => src.Documents))

                     .ForMember(dest => dest.Reviews,
                         opts => opts.MapFrom(src => src.Reviews));
                map.ReverseMap();
            }
        }
    }
}
