//
//  AppDependencyContainer.swift
//  QuranMajeed
//
//  Created by Takasur Azeem on 14/09/2023.
//

import Foundation
import Analytics
import AppDependencies
import BatchDownloader
import CoreDataModel
import CoreDataPersistence
import LastPagePersistence
import NotePersistence
import PageBookmarkPersistence
import ReadingService
import Logging
import VLogging

class AppDependencyContainer: AppDependencies {
    var logsDirectory: URL { FileManager.documentsURL.appendingPathComponent("logs") }

    var databasesDirectory: URL { Constant.databasesURL }

    private(set) lazy var readingResources = ReadingResourcesService(downloader: downloadManager, remoteResources: remoteResources)

    var remoteResources: (any ReadingService.ReadingRemoteResources)?

    private init() {
        self.theQuranProvider = MainQuranProvider()   
    }

    static let shared = AppDependencyContainer()

    lazy var theQuranDependencyContainer: QuranDataDependencyContainer = {
        QuranDataDependencyContainer(providerForQuran: theQuranProvider)
    }()

    lazy var quizPreferenncesDependencyContainer: QuizPreferencesDependencyContainer = {
        QuizPreferencesDependencyContainer(
            dataStore: MainQuizPreferencesDataStore(
                dataStore: FileDatastore(
                    purpose: "quizPreferences"
                )
            )
        )
    }()

    lazy var attributedTranslationTextProvider: AttributedTranslationTextProvider = {
        return MainAttributedTranslationTextProvider()
    }()

    lazy var a4PageSizeProvider: PageSizeProvider = {
        return A4PageSizeProvider()
    }()
    
    lazy var numberOfLinesProvider: NumberOfLinesProvider = {
        return MainNumberOfLinesProvider(
            translationTextAttributesProvider: attributedTranslationTextProvider,
            pageSizeProvider: a4PageSizeProvider
        )
    }()
    
    let analytics: AnalyticsLibrary = LoggingAnalyticsLibrary()

    private(set) lazy var lastPagePersistence: LastPagePersistence = CoreDataLastPagePersistence(stack: coreDataStack)
    private(set) lazy var pageBookmarkPersistence: PageBookmarkPersistence = CoreDataPageBookmarkPersistence(stack: coreDataStack)
    private(set) lazy var notePersistence: NotePersistence = CoreDataNotePersistence(stack: coreDataStack)

    private(set) lazy var downloadManager: DownloadManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "DownloadsBackgroundIdentifier")
        configuration.timeoutIntervalForRequest = 60 * 5 // 5 minutes
        return DownloadManager(
            maxSimultaneousDownloads: 600,
            configuration: configuration,
            downloadsURL: Constant.databasesURL.appendingPathComponent("downloads.db", isDirectory: false)
        )
    }()

    var databasesURL: URL { Constant.databasesURL }
    var wordsDatabase: URL { Constant.wordsDatabase }
    var filesAppHost: URL { Constant.filesAppHost }
    var appHost: URL { Constant.appHost }

    var supportsCloudKit: Bool { false }

    // MARK: Private

    private lazy var coreDataStack: CoreDataStack = {
        let stack = CoreDataStack(name: "Quran", modelUrl: CoreDataModelResources.quranModel) {
            let lastPage = CoreDataLastPageUniquifier()
            let pageBookmark = CoreDataPageBookmarkUniquifier()
            let note = CoreDataNoteUniquifier()
            return [lastPage, pageBookmark, note]
        }
        return stack
    }()

    private let theQuranProvider: QuranProvider
}

private enum Constant {
    static let wordsDatabase = Bundle.main
        .url(forResource: "words", withExtension: "db")!

    static let appHost: URL = URL(validURL: "https://quran.app/")

    static let filesAppHost: URL = URL(validURL: "https://files.quran.app/")

    static let databasesURL = FileManager.documentsURL
        .appendingPathComponent("databases", isDirectory: true)
}
