{ inputs, ... }: {
	flake.nixosModules.wilotiZenBrowser = { pkgs, lib, ... }: {
		home-manager.users.wiloti = {
			imports = [ inputs.zen-browser.homeModules.twilight ];
			programs.zen-browser = {
				enable = true;
                policies = {
                    AutofillCreditCardEnabled = false;
                    DisableAppUpdate = true;
                    DisableFeedbackCommands = true;
                    DisableFirefoxStudies = true;
                    DisablePocket = true;
                    DisableTelemetry = true;
                    DontCheckDefaultBrowser = true;
                    NoDefaultBookmarks = true;
                    OfferToSaveLogins = false;
                    EnableTrackingProtection = {
                        Value = true;
                        Locked = true;
                        Cryptomining = true;
                        FingerPrinting = true;
                    };

                    ExtensionSettings = {
                        "passbolt@passbolt.com" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/passbolt/latest.xpi";
                            installation_mode = "force_installed";
                        };
                        "uBlock0@raymondhill.net" = {
                            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                            installation_mode = "force_installed";
                        };
                    };

                };

				profiles.wiloti = {
					isDefault = true;
					search = {
						force = true;
						default = "ddg";
                        engines = {
                            github = {
                                name = "Github Search";
                                urls = [
                                    {
                                        template = "https://github.com/search?q={searchTerms}";
                                    }
                                ];
                                definedAliases = ["@gh"];
                            };
                        };
					};
                    mods = [
                        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
                        "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
                        "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
                        "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
                        "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
                        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
                        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find bar
                        "1b88a6d1-d931-45e8-b6c3-bfdca2c7e9d6" # Remove Tab X
                    ];
                    keyboardShortcuts = [
                        {
                            id = "zen-compact-mode-toggle";
                            key = "s";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-workspace-forward";
                            key = "e";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-workspace-backward";
                            key = "q";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-split-view-vertical";
                            key = ",";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-split-view-unsplit";
                            key = ".";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-glance-expand";
                            key = "o";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-copy-url-markdown";
                            key = "m";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-copy-url";
                            key = "m";
                            modifiers = {
                                control = true;
                                alt = true;
                            };
                        }
                        {
                            id = "new_NavigatorTab";
                            key = "t";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_close";
                            key = "w";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_reload";
                            key = "r";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_reload_skip_cache";
                            key = "r";
                            modifiers = {
                                control = true;
                                shift = true;
                            };
                        }
                        {
                            id = "key_privatebrowsing";
                            key = "g";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_search";
                            key = "k";
                        }
                        {
                            id = "key_gotoHistory";
                            key = "h";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_find";
                            key = "f";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_findPrevious";
                            key = "p";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_findAgain";
                            key = "n";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_focusURLBar";
                            key = "l";
                            modifiers = {
                                control =  true;
                            };
                        }
                        {
                            id ="key_toggleReaderMode";
                            key = "y";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_viewSource";
                            key = "u";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_viewInfo";
                            key = "i";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_toggleMute";
                            key = "m";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_fullZoomReduce";
                            key = "8";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_fullZoomEnlarge";
                            key = "9";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_fullZoomReset";
                            key = "0";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "key_toggleToolbox";
                            key = "j";
                            modifiers = {
                                control = true;
                            };
                        }
                        {
                            id = "zen-toggle-sidebar";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-created";
                            disabled = true;
                        }
                        {
                            id = "zen-close-all-unpinned-tabs";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-1";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-2";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-3";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-4";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-5";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-6";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-7";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-8";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-9";
                            disabled = true;
                        }
                        {
                            id = "zen-workspace-switch-10";
                            disabled = true;
                        }
                        {
                            id = "zen-new-empty-split-view";
                            disabled = true;
                        }
                        {
                            id = "zen-split-view-horizontal";
                            disabled = true;
                        }
                        {
                            id = "zen-split-view-grid";
                            disabled = true;
                        }
                        {
                            id = "zen-new-unsynced-window";
                            disabled = true;
                        }
                        {
                            id = "zen-toggle-pin-tab";
                            disabled = true;
                        }
                        {
                            id = "zen-duplicate-tab";
                            disabled = true;
                        }
                        {
                            id = "key_duplicateTab";
                            disabled = true;
                        }
                        {
                            id = "key_newNavigator";
                            disabled = true;
                        }
                        {
                            id = "key_quitApplication";
                            disabled = true;
                        }
                        {
                            id = "key_closeWindow";
                            disabled = true;
                        }
                        {
                            id = "key_restoreLastClosedTabOrWindowOrSession";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab1";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab2";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab3";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab4";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab5";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab6";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab7";
                            disabled = true;
                        }
                        {
                            id = "key_selectTab8";
                            disabled = true;
                        }
                        {
                            id = "key_selectLastTab";
                            disabled = true;
                        }
                        {
                            id = "goHome";
                            disabled = true;
                        }
                        {
                            id = "goForwardKb";
                            disabled = true;
                        }
                        {
                            id = "goForwardKb2";
                            disabled = true;
                        }
                        {
                            id = "goBackKb";
                            disabled = true;
                        }
                        {
                            id = "goBackKb2";
                            disabled = true;
                        }
                        {
                            id = "key_search2";
                            disabled = true;
                        }
                        {
                            id = "key_focusURLBar2";
                            disabled = true;
                        }
                        {
                            id = "key_savePage";
                            disabled = true;
                        }
                        {
                            id = "printKb";
                            disabled = true;
                        }
                        {
                            id ="key_togglePictureInPicture";
                            disabled = true;
                        }
                        {
                            id = "showAllHistoryKb";
                            disabled = true;
                        }
                        {
                            id = "viewBookmarksToolbarKb";
                            disabled = true;
                        }
                        {
                            id = "viewBookmarksSidebarKb";
                            disabled = true;
                        }
                        {
                            id = "manBookmarkKb";
                            disabled = true;
                        }
                        {
                            id = "addBookmarkAsKb";
                            disabled = true;
                        }
                        {
                            id = "key_switchTextDirection";
                            disabled = true;
                        }
                        {
                            id = "key_screenshot";
                            disabled = true;
                        }
                        {
                            id = "key_browserToolbox";
                            disabled = true;
                        }
                        {
                            id = "key_webconsole";
                            disabled = true;
                        }
                        {
                            id = "key_browserConsole";
                            disabled = true;
                        }
                        {
                            id = "key_responsiveDesignMode";
                            disabled = true;
                        }
                        {
                            id = "key_inspector";
                            disabled = true;
                        }
                        {
                            id = "key_jsdebugger";
                            disabled = true;
                        }
                        {
                            id = "key_netmonitor";
                            disabled = true;
                        }
                        {
                            id = "key_styleeditor";
                            disabled = true;
                        }
                        {
                            id = "key_performance";
                            disabled = true;
                        }
                        {
                            id = "key_storage";
                            disabled = true;
                        }
                        {
                            id = "key_dom";
                            disabled = true;
                        }
                        {
                            id = "key_accessibility";
                            disabled = true;
                        }
                        {
                            id = "key_openDownloads";
                            disabled = true;
                        }
                        {
                            id = "key_openAddons";
                            disabled = true;
                        }
                        {
                            id = "key_delete";
                            disabled = true;
                        }
                        {
                            id = "key_enterFullScreen";
                            disabled = true;
                        }{
                            id = "key_exitFullScreen";
                            disabled = true;
                        }
                        {
                            id = "key_aboutProcesses";
                            disabled = true;
                        }
                        {
                            id = "viewGenaiChatSidebarKb";
                            disabled = true;
                        }
                        {
                            id = "toggleSidebarKb";
                            disabled = true;
                        }
                        {
                            id = "key_showAllTabs";
                            disabled = true;
                        }
                        {
                            id = "key_wrToggleCaptureSequenceCmd";
                            disabled = true;
                        }
                        {
                            id = "key_wrCaptureCmd";
                            disabled = true;
                        }
                        {
                            id = "zen-compact-mode-show-sidebar";
                            disabled = true;
                        }
                    ];
                    keyboardShortcutsVersion = 18;
				};
			};
		};
	};
}
