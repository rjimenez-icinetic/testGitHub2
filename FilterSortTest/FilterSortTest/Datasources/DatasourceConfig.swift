//
//  DatasourceConfig.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation
 
 enum DatasourceConfig {

	
	enum Local {

		enum LocalDSDS{
			
			static let resource = "LocalDSDS"
		}

		enum DoubleFilterLocalDS{
			
			static let resource = "DoubleFilterLocalDS"
		}
	}
	 
	
	enum Cloud {
		
		static let baseUrl = "https://baked-devel.herokuapp.com"

		enum BuildupCloudDSDS{
			
			static let resource = "/app/57a482ee9ba9230300922824/r/buildupCloudDSDS"
			static let apiKey = "QBtB220A"
		}

		enum DoubleFilterBCScreen1DS{
			
			static let resource = "/app/57a482ee9ba9230300922824/r/doubleFilterBCScreen1DS"
			static let apiKey = "QBtB220A"
		}
	}

	
	enum External {
		
		static let baseUrl = "http:\\localhost/api/app/data"
        static let appIdentifier = "29b80895-6f6c-4117-8085-6473d5c54772"
        static let apiKey = "gS4kAr69dLXXACsUwBuxMcxRuWBflLs0oMYz7GwjBj"

		enum GoogleSheetDSDS{
			
			static let identifier = "c5f8b22c-509e-4f07-b7b6-75555940635c"
		}

		enum ExcelOnlineScreen1DS{
			
			static let identifier = "985dea23-b412-4bc1-b248-862e19eec99a"
		}

		enum GoogleDriveScreen1DS{
			
			static let identifier = "c0e66b96-d278-4e01-838b-bb8b4cfc6ada"
		}
	}

}
