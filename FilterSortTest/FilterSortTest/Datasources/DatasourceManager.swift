//
//  DatasourceManager.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

class DatasourceManager {

	static let sharedInstance = DatasourceManager()
	
	lazy var LocalDSDS: LocalDatasource<LocalDSDSSchemaItem> = {
    
        return LocalDatasource<LocalDSDSSchemaItem>(resource: DatasourceConfig.Local.LocalDSDS.resource) 
    }()
	
	lazy var DoubleFilterLocalDS: LocalDatasource<DoubleFilterLocalDSSchemaItem> = {
    
        return LocalDatasource<DoubleFilterLocalDSSchemaItem>(resource: DatasourceConfig.Local.DoubleFilterLocalDS.resource) 
    }()
	
	
	lazy var BuildupCloudDSDS: CloudDatasource<BuildupCloudDSDSItem> = {
    
        return CloudDatasource<BuildupCloudDSDSItem>(baseUrl: DatasourceConfig.Cloud.baseUrl,
                                             resource: DatasourceConfig.Cloud.BuildupCloudDSDS.resource,
                                             apikey: DatasourceConfig.Cloud.BuildupCloudDSDS.apiKey,
                                             searchableFields: [BuildupCloudDSDSItemMapping.text1, BuildupCloudDSDSItemMapping.text2, BuildupCloudDSDSItemMapping.text3]) 
    }()
	
	lazy var DoubleFilterBCScreen1DS: CloudDatasource<DoubleFilterBCScreen1DSItem> = {
    
        return CloudDatasource<DoubleFilterBCScreen1DSItem>(baseUrl: DatasourceConfig.Cloud.baseUrl,
                                             resource: DatasourceConfig.Cloud.DoubleFilterBCScreen1DS.resource,
                                             apikey: DatasourceConfig.Cloud.DoubleFilterBCScreen1DS.apiKey,
                                             searchableFields: [DoubleFilterBCScreen1DSItemMapping.text1, DoubleFilterBCScreen1DSItemMapping.text2, DoubleFilterBCScreen1DSItemMapping.text3]) 
    }()
	
	lazy var GoogleSheetDSDS: ExternalDatasource<Hoja1Item> = {
    
        return ExternalDatasource<Hoja1Item>(identifier: DatasourceConfig.External.GoogleSheetDSDS.identifier,
                                             baseUrl: DatasourceConfig.External.baseUrl,
                                             appIdentifier: DatasourceConfig.External.appIdentifier,
                                             apikey: DatasourceConfig.External.apiKey)
    }()
	
	lazy var ExcelOnlineScreen1DS: ExternalDatasource<Hoja1Schema1Item> = {
    
        return ExternalDatasource<Hoja1Schema1Item>(identifier: DatasourceConfig.External.ExcelOnlineScreen1DS.identifier,
                                             baseUrl: DatasourceConfig.External.baseUrl,
                                             appIdentifier: DatasourceConfig.External.appIdentifier,
                                             apikey: DatasourceConfig.External.apiKey)
    }()
	
	lazy var GoogleDriveScreen1DS: ExternalDatasource<GoogleDriveScreen1DSSchemaItem> = {
    
        return ExternalDatasource<GoogleDriveScreen1DSSchemaItem>(identifier: DatasourceConfig.External.GoogleDriveScreen1DS.identifier,
                                             baseUrl: DatasourceConfig.External.baseUrl,
                                             appIdentifier: DatasourceConfig.External.appIdentifier,
                                             apikey: DatasourceConfig.External.apiKey)
    }()
	
}
