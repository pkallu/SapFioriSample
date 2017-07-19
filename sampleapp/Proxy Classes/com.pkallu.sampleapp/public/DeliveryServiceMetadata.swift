// # Proxy Compiler 17.5.3-9e1425-20170523

import Foundation
import SAPOData

public class DeliveryServiceMetadata {
    public static let source: String = "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\" ?><edmx:Edmx Version=\"1.0\" xmlns:edmx=\"http://schemas.microsoft.com/ado/2007/06/edmx\"><edmx:DataServices xmlns:m=\"http://schemas.microsoft.com/ado/2007/08/dataservices/metadata\" m:DataServiceVersion=\"2.0\"><Schema Namespace=\"codejam.wwdc.services.DeliveryService\" xmlns:d=\"http://schemas.microsoft.com/ado/2007/08/dataservices\" xmlns:m=\"http://schemas.microsoft.com/ado/2007/08/dataservices/metadata\" xmlns=\"http://schemas.microsoft.com/ado/2008/09/edm\"><EntityType Name=\"DeliveryStatusType\"><Key><PropertyRef Name=\"DeliveryStatusID\" /></Key><Property Name=\"DeliveryStatusID\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"36\" /><Property Name=\"PackageID\" Type=\"Edm.String\" MaxLength=\"36\" /><Property Name=\"Location\" Type=\"Edm.String\" MaxLength=\"256\" /><Property Name=\"DeliveryTimestamp\" Type=\"Edm.DateTime\" /><Property Name=\"StatusType\" Type=\"Edm.String\" MaxLength=\"16\" /><Property Name=\"Selectable\" Type=\"Edm.Int32\" /><Property Name=\"Status\" Type=\"Edm.String\" MaxLength=\"128\" /></EntityType><EntityType Name=\"PackagesType\"><Key><PropertyRef Name=\"PackageID\" /></Key><Property Name=\"PackageID\" Type=\"Edm.String\" Nullable=\"false\" MaxLength=\"36\" /><Property Name=\"Name\" Type=\"Edm.String\" MaxLength=\"256\" /><Property Name=\"Description\" Type=\"Edm.String\" MaxLength=\"256\" /><Property Name=\"Price\" Type=\"Edm.Decimal\" Precision=\"10\" Scale=\"2\" /><NavigationProperty Name=\"DeliveryStatus\" Relationship=\"codejam.wwdc.services.DeliveryService.PackageDeliveryStatusType\" FromRole=\"PackagesPrincipal\" ToRole=\"DeliveryStatusDependent\" /></EntityType><Association Name=\"PackageDeliveryStatusType\"><End Type=\"codejam.wwdc.services.DeliveryService.PackagesType\" Role=\"PackagesPrincipal\" Multiplicity=\"1\"/><End Type=\"codejam.wwdc.services.DeliveryService.DeliveryStatusType\" Role=\"DeliveryStatusDependent\" Multiplicity=\"*\"/><ReferentialConstraint><Principal Role=\"PackagesPrincipal\"><PropertyRef Name=\"PackageID\"/></Principal><Dependent Role=\"DeliveryStatusDependent\"><PropertyRef Name=\"PackageID\"/></Dependent></ReferentialConstraint></Association><EntityContainer Name=\"DeliveryService\" m:IsDefaultEntityContainer=\"true\"><EntitySet Name=\"DeliveryStatus\" EntityType=\"codejam.wwdc.services.DeliveryService.DeliveryStatusType\" /><EntitySet Name=\"Packages\" EntityType=\"codejam.wwdc.services.DeliveryService.PackagesType\" /><AssociationSet Name=\"PackageDeliveryStatus\" Association=\"codejam.wwdc.services.DeliveryService.PackageDeliveryStatusType\"><End Role=\"PackagesPrincipal\" EntitySet=\"Packages\"/><End Role=\"DeliveryStatusDependent\" EntitySet=\"DeliveryStatus\"/></AssociationSet></EntityContainer></Schema></edmx:DataServices></edmx:Edmx>\n"

    internal static let parsed: CSDLDocument = DeliveryServiceMetadata.parse()

    public static let document: CSDLDocument = DeliveryServiceMetadata.resolve()

    static func parse() -> CSDLDocument {
        let parser: CSDLParser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = (CSDLOption.processMixedVersions | CSDLOption.retainOriginalText | CSDLOption.ignoreUndefinedTerms)
        return parser.parseInProxy(DeliveryServiceMetadata.source, url: "codejam.wwdc.services.DeliveryService")
    }

    static func resolve() -> CSDLDocument {
        DeliveryServiceMetadata.EntityTypes.deliveryStatusType.registerFactory(ObjectFactory.with(create: { DeliveryStatusType() }))
        DeliveryServiceMetadata.EntityTypes.packagesType.registerFactory(ObjectFactory.with(create: { PackagesType() }))
        return DeliveryServiceMetadata.parsed
    }

    public class EntityTypes {
        public static let deliveryStatusType: EntityType = DeliveryServiceMetadata.parsed.entityType(withName: "codejam.wwdc.services.DeliveryService.DeliveryStatusType")

        public static let packagesType: EntityType = DeliveryServiceMetadata.parsed.entityType(withName: "codejam.wwdc.services.DeliveryService.PackagesType")
    }

    public class EntitySets {
        public static let deliveryStatus: EntitySet = DeliveryServiceMetadata.parsed.entitySet(withName: "DeliveryStatus")

        public static let packages: EntitySet = DeliveryServiceMetadata.parsed.entitySet(withName: "Packages")
    }
}
