var YOCTagJSTools;
if (typeof (YOCTagJSTools) == "undefined") {
    YOCTagJSTools = function() {
        try {
            this.bIsError = false;
            this.sHostName = "tag.yoc-adserver.com";
            this.bIsHTTPS = "https:" == document.location.protocol;
            this.bIsDebug = (document.location.href.indexOf("YOCTagDebug") > -1 || (typeof (YOCTagJSConfigSystem) == "object" && typeof (YOCTagJSConfigSystem.debug) == "boolean" && YOCTagJSConfigSystem.debug) ? true : false);
            this.bInvalidateContainer = (typeof (YOCTagJSConfigSystem) == "object" && typeof (YOCTagJSConfigSystem.invalidate_container) == "boolean" && !YOCTagJSConfigSystem.invalidate_container ? false : true);
            this.bRenderingAsynchronous = (typeof (YOCTagJSConfigSystem) == "object" && typeof (YOCTagJSConfigSystem.rendering_asynchronous) == "boolean" && !YOCTagJSConfigSystem.rendering_asynchronous ? false : true);
            this.oHead = document.getElementsByTagName("head")[0];
            this.oBody = document.getElementsByTagName("body")[0];
            this.sVersion = "v2_03_0000";
            this.sInvalidAdSpaceContainerPrefix = "YOCTagJS_invalid_adspace_container_"
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSTools.constructor() Exception: " + a)
        }
    };
    YOCTagJSTools.prototype.documentWrite = function(a) {
        try {
            document.write(a)
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.documentWrite() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.loadScriptHead = function(b, d, a) {
        try {
            oScript = document.createElement("script");
            oScript.type = "text/javascript";
            oScript.reference = a;
            oScript.src = (this.bIsHTTPS ? "https" : "http") + "://" + b;
            oScript.onload = d;
            this.oHead.appendChild(oScript)
        } catch (c) {
            YOCTagJSTools.error("YOCTagJSTools.loadScriptHead() Exception: " + c)
        }
    };
    YOCTagJSTools.prototype.loadScriptDirect = function(b, c, a) {
        try {
            this.documentWrite('<script src="' + (this.bIsHTTPS ? "https" : "http") + "://" + b + '" reference="' + a + '" onload="' + c + '"><\/script>')
        } catch (d) {
            YOCTagJSTools.error("YOCTagJSTools.loadScriptDirect() Exception: " + d)
        }
    };
    YOCTagJSTools.prototype.loadScriptInContainer = function(a, c, e, b) {
        try {
            oScript = document.createElement("script");
            oScript.type = "text/javascript";
            oScript.reference = b;
            oScript.src = (this.bIsHTTPS ? "https" : "http") + "://" + c;
            oScript.onload = e;
            a.oYOCTagJSAdSpaceContainer.appendChild(oScript)
        } catch (d) {
            YOCTagJSTools.error("YOCTagJSTools.loadScriptInContainer() Exception: " + d)
        }
    };
    YOCTagJSTools.prototype.extendConfig = function(b, c, e) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSTools.extendConfig() - sID: "' + b + '" - sReference: "' + c + '" - oConfig: ' + JSON.stringify(e));
            if ((typeof (b) == "undefined" || b.length < 1) && (typeof (c) != "undefined" && c.length > 0)) {
                b = YOCTagJSTools.determineID(c)
            }
            if ((typeof (c) == "undefined" || c.length < 1) && (typeof (b) != "undefined" && b.length > 0)) {
                c = YOCTagJSTools.determineReference(b)
            }
            YOCTagJSTools.log('YOCTagJSTools.extendConfig() - sID: "' + b + '" - sReference: "' + c + '" - oConfig: ' + JSON.stringify(e));
            if (e instanceof Object && YOCTagJSConfig instanceof Object) {
                if (typeof (e.reference) != "undefined") {
                    oConfigNew = new Array();
                    oConfigNew[e.reference] = e;
                    e = oConfigNew;
                    YOCTagJSTools.log('YOCTagJSTools.extendConfig() - Changed config structure - sID: "' + b + '" - sReference: "' + c + '" - oConfig: ' + JSON.stringify(e))
                }
                for (var a in e) {
                    if (e.hasOwnProperty(a)) {
                        oConfigValue = e[a];
                        YOCTagJSTools.log('YOCTagJSTools.extendConfig() - config found - "' + a + '": ' + JSON.stringify(oConfigValue));
                        for (var d in oConfigValue) {
                            if (oConfigValue.hasOwnProperty(d)) {
                                oConfigChildValue = oConfigValue[d];
                                YOCTagJSTools.log('YOCTagJSTools.extendConfig() - config child found - "' + d + '": ' + JSON.stringify(oConfigChildValue));
                                if (typeof (YOCTagJSConfig[b]) == "undefined") {
                                    YOCTagJSConfig[b] = {}
                                }
                                YOCTagJSConfig[b][d] = oConfigChildValue
                            }
                        }
                    }
                }
            }
        } catch (f) {
            YOCTagJSTools.error("YOCTagJSTools.extendConfig() Exception: " + f)
        }
    };
    YOCTagJSTools.prototype.determineID = function(a) {
        try {
            YOCTagJSTools.log("Enter YOCTagJSTools.determineID() - sReference: " + a);
            sID = a;
            if (YOCTagJSConfig instanceof Object) {
                for (var c in YOCTagJSConfig) {
                    if (YOCTagJSConfig.hasOwnProperty(c)) {
                        oYOCTagJSConfigValue = YOCTagJSConfig[c];
                        if (typeof (oYOCTagJSConfigValue.reference) != "undefined" && oYOCTagJSConfigValue.reference == a) {
                            sID = c
                        } else {
                            if (c == a) {
                                sID = a
                            }
                        }
                    }
                }
            }
            YOCTagJSTools.log('YOCTagJSTools.determineID() - sReference: "' + a + '" - Found ID: "' + sID + '"');
            return sID
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.determineID() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.determineReference = function(a) {
        try {
            YOCTagJSTools.log("Enter YOCTagJSTools.determineReference() - sID: " + a);
            sReference = a;
            if (YOCTagJSConfig instanceof Object && typeof (YOCTagJSConfig[a]) != "undefined") {
                if (typeof (YOCTagJSConfig[a].reference) != "undefined") {
                    sReference = YOCTagJSConfig[a].reference
                }
            }
            YOCTagJSTools.log('YOCTagJSTools.determineReference() - sID: "' + a + '" - Found reference: "' + sReference + '"');
            return sReference
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.determineReference() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.determineIDFromDivID = function(a) {
        try {
            YOCTagJSTools.log("Enter YOCTagJSTools.determineIDFromDivID() - sDivID: " + a);
            sID = "";
            if (YOCTagJSConfig instanceof Object) {
                for (var c in YOCTagJSConfig) {
                    if (YOCTagJSConfig.hasOwnProperty(c)) {
                        oYOCTagJSConfigValue = YOCTagJSConfig[c];
                        if (typeof (oYOCTagJSConfigValue.container_id) != "undefined" && oYOCTagJSConfigValue.container_id == a) {
                            sID = c
                        }
                    }
                }
            }
            YOCTagJSTools.log('YOCTagJSTools.determineIDFromDivID() - sDivID: "' + a + '" - Found ID: "' + sID + '"');
            return sID
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.determineIDFromDivID() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.createChildAdSpaceContainer = function(e, d, b, a, c, f) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSTools.createChildAdSpaceContainer() - sAdSpaceContainerID: "' + e + '" - sReference: "' + d + '" - bInvalidateAll: "' + (a ? "TRUE" : "FALSE") + '" - bCleanUpAll: "' + (c ? "TRUE" : "FALSE") + '" - bMoveContainer: "' + (f ? "TRUE" : "FALSE") + '"');
            bCreateChildAdSpaceContainer = true;
            if (a) {
                YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Try to invalidate child adspace container ...");
                while (oAdSpaceContainerChild = document.getElementById(e)) {
                    if (oAdSpaceContainerChild) {
                        YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Invalidate child adspace container OK");
                        oAdSpaceContainerChild.id = "YOCTagJS_Child_invalid_adspace_container_" + d;
                        if (c) {
                            YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Clean up child adspace container OK");
                            oAdSpaceContainerChild.innerHTML = ""
                        } else {
                            YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Do not clean up child adspace container")
                        }
                    } else {
                        YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Invalidate child adspace container FAILED")
                    }
                }
            } else {
                YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Do not invalidate child adspace container ...")
            }
            if (f) {
                YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Try to move child adspace container ...");
                oAdSpaceContainerChild = document.getElementById(e);
                if (oAdSpaceContainerChild) {
                    YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Child adspace container found and move");
                    bCreateChildAdSpaceContainer = false;
                    b.innerHTML = "";
                    b.appendChild(oAdSpaceContainerChild)
                } else {
                    YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Child adspace container NOT found");
                    bCreateChildAdSpaceContainer = true
                }
            }
            if (bCreateChildAdSpaceContainer) {
                YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Create child adspace container");
                b.innerHTML = '<div id="' + e + '" reference="' + d + '"></div>'
            } else {
                YOCTagJSTools.log("YOCTagJSTools.createChildAdSpaceContainer() - Create child adspace container not needed")
            }
        } catch (g) {
            YOCTagJSTools.error("YOCTagJSTools.createChildAdSpaceContainer() Exception: " + g)
        }
    };
    YOCTagJSTools.prototype.showAdSpaces = function(c, b, a) {
        try {
            if (typeof (a) == "undefined") {
                a = "x"
            }
            YOCTagJSTools.log("YOCTagJSTools.showAdSpaces() - " + a + ' - oDIV: "' + typeof (c) + '" - bRecycleAdSpaceContainer: "' + b + '"');
            if (c instanceof Object && typeof (c.nodeName) != "undefined" && c.nodeName.toUpperCase() == "DIV") {
                YOCTagJSTools.log("YOCTagJSTools.showAdSpaces() - " + a + ' - found DIV ID: "' + c.id + '"');
                if (typeof (c.children) != "undefined") {
                    YOCTagJSTools.log("YOCTagJSTools.showAdSpaces() - " + a + ' - found "' + c.children.length + '" childs in DIV ID: "' + c.id + '"');
                    for (var d in c.children) {
                        if (c.children.hasOwnProperty(d)) {
                            oValue = c.children[d];
                            if (oValue instanceof Object && typeof (oValue.nodeName) != "undefined" && oValue.nodeName.toUpperCase() == "DIV") {
                                sDivID = oValue.id;
                                sYOCTagConfigID = YOCTagJSTools.determineIDFromDivID(sDivID);
                                if (sYOCTagConfigID != "") {
                                    YOCTagJSTools.log('YOCTagJSTools.showAdSpaces() - Show adspace with config id: "' + sYOCTagConfigID + '" and DIV ID: "' + sDivID + '"');
                                    new YOCTagJS(sYOCTagConfigID)
                                } else {
                                    if (sDivID.indexOf(YOCTagJSTools.sInvalidAdSpaceContainerPrefix) === 0) {
                                        sReference = sDivID.substr(YOCTagJSTools.sInvalidAdSpaceContainerPrefix.length);
                                        sYOCTagConfigID = YOCTagJSTools.determineID(sReference);
                                        if (typeof (YOCTagJSConfig) != "undefined" && typeof (YOCTagJSConfig[sYOCTagConfigID]) != "undefined" && typeof (YOCTagJSConfig[sYOCTagConfigID].container_id) != "undefined") {
                                            YOCTagJSTools.log('YOCTagJSTools.showAdSpaces() - Reuse invalidated adspace with config id: "' + sYOCTagConfigID + '" and Reference: "' + sReference + '" and DIV ID: "' + sDivID + '"');
                                            oValue.id = YOCTagJSConfig[sYOCTagConfigID].container_id;
                                            YOCTagJSTools.log('YOCTagJSTools.showAdSpaces() - Show invalidated adspace (container ID: "' + YOCTagJSConfig[sYOCTagConfigID].container_id + '") with config id: "' + sYOCTagConfigID + '" and Reference: "' + sReference + '" and DIV ID: "' + sDivID + '"');
                                            new YOCTagJS(sYOCTagConfigID)
                                        } else {
                                            YOCTagJSTools.log('YOCTagJSTools.showAdSpaces() - Determine container ID FAILED for config id: "' + sYOCTagConfigID + '" and Reference: "' + sReference + '" and DIV ID: "' + sDivID + '"')
                                        }
                                    } else {
                                        YOCTagJSTools.showAdSpaces(oValue, b, a + "X")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (e) {
            YOCTagJSTools.error("YOCTagJSTools.showAdSpaces() Exception: " + e)
        }
    };
    YOCTagJSTools.prototype.log = function(a) {
        try {
            if (YOCTagJSTools.bIsDebug) {
                console.log(a)
            }
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.log() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.debug = function(a) {
        try {
            if (YOCTagJSTools.bIsDebug) {
                console.debug(a)
            }
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.debug() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.info = function(a) {
        try {
            if (YOCTagJSTools.bIsDebug) {
                console.info(a)
            }
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.info() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.warn = function(a) {
        try {
            console.warn(a)
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSTools.warn() Exception: " + b)
        }
    };
    YOCTagJSTools.prototype.error = function(a) {
        try {
            console.error(a)
        } catch (b) {
        }
    };
    YOCTagJSTools = new YOCTagJSTools()
}
var YOCTagJSEvent;
if (typeof (YOCTagJSEvent) == "undefined") {
    YOCTagJSEvent = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSEvent.constructor()");
            this.aListener = new Array();
            this.aListener.init = new Array();
            this.aListener.beforeAdRequest = new Array();
            this.aListener.afterAdRequest = new Array();
            this.aListenerPerformed = new Array();
            this.aListenerPerformed.init = false;
            this.aListenerPerformed.beforeAdRequest = false;
            this.aListenerPerformed.afterAdRequest = false
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSEvent.constructor() Exception: " + a)
        }
    };
    YOCTagJSEvent.prototype.add = function(d, a, b, c) {
        try {
            if (typeof c == "undefined") {
                c = false
            }
            YOCTagJSTools.log('Enter YOCTagJSEvent.add() - Event: "' + d + '" - ID: "' + a + '" - bPerformAlsoAfterEvent: ' + (c ? "TRUE" : "FALSE"));
            if (typeof this.aListener != "undefined") {
                if (typeof this.aListener[d] == "undefined") {
                    this.aListener[d] = new Array()
                }
                this.aListener[d][a] = b;
                if (c && typeof this.aListenerPerformed[d] == "boolean" && this.aListenerPerformed[d]) {
                    YOCTagJSTools.log('YOCTagJSEvent.add() - Run Event: "' + d + '" - ID: "' + a + '"');
                    try {
                        b(d, {})
                    } catch (e) {
                        YOCTagJSTools.error('YOCTagJSEvent.add() - Run Event: "' + d + '" - ID: "' + a + '" - Exception: ' + e)
                    }
                }
                return true
            }
            return false
        } catch (e) {
            YOCTagJSTools.error("YOCTagJSEvent.add() Exception: " + e)
        }
    };
    YOCTagJSEvent.prototype.run = function(b, a) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSEvent.run() - Event: "' + b + '"');
            if (typeof this.aListener[b] != "undefined") {
                this.aListenerPerformed[b] = true;
                for (var d in this.aListener[b]) {
                    if (this.aListener[b].hasOwnProperty(d)) {
                        oListenerFunction = this.aListener[b][d];
                        YOCTagJSTools.log('YOCTagJSEvent.run() - Event: "' + b + '" - Listener: "' + d + '"');
                        try {
                            oListenerFunction(b, a)
                        } catch (c) {
                            YOCTagJSTools.error('YOCTagJSEvent.run() - Event: "' + b + '" - Listener: "' + d + '" - Exception: ' + c)
                        }
                    }
                }
                return true
            }
            return false
        } catch (c) {
            YOCTagJSTools.error("YOCTagJSEvent.run() Exception: " + c)
        }
    };
    YOCTagJSEvent = new YOCTagJSEvent()
}
var YOCTagJSStorage;
if (typeof (YOCTagJSStorage) == "undefined") {
    YOCTagJSStorage = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSStorage.constructor()");
            this.aData = new Array()
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSStorage.constructor() Exception: " + a)
        }
    };
    YOCTagJSStorage.prototype.addStorage = function(a) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSStorage.addStorage() - : "' + a + '"');
            this.aData[a] = new Array();
            this.aData[a]["call_counter"] = 0
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSStorage.addStorage() Exception: " + b)
        }
    };
    YOCTagJSStorage.prototype.existsStorage = function(a) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSStorage.existsStorage() - : "' + a + '"');
            if (typeof this.aData[a] != "undefined") {
                return true
            }
            return false
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSStorage.existsStorage() Exception: " + b)
        }
    };
    YOCTagJSStorage.prototype.exists = function(a, b) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSStorage.exists() - sID: "' + a + '" - sKey: "' + b + '"');
            if (!YOCTagJSStorage.existsStorage(a)) {
                return false
            }
            if (typeof this.aData[a][b] == "undefined") {
                return false
            }
            return true
        } catch (c) {
            YOCTagJSTools.error("YOCTagJSStorage.exists() Exception: " + c)
        }
    };
    YOCTagJSStorage.prototype.get = function(a, b) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSStorage.get() - sID: "' + a + '" - sKey: "' + b + '"');
            if (!YOCTagJSStorage.existsStorage(a)) {
                YOCTagJSTools.error('YOCTagJSStorage.get() - ID: "' + a + '" does not exist');
                return null
            }
            if (typeof this.aData[a][b] == "undefined") {
                YOCTagJSTools.error('YOCTagJSStorage.get() - Key "' + b + '" for ID "' + a + '" does not exist');
                return null
            }
            return this.aData[a][b]
        } catch (c) {
            YOCTagJSTools.error("YOCTagJSStorage.get() Exception: " + c)
        }
    };
    YOCTagJSStorage.prototype.set = function(a, c, b) {
        try {
            YOCTagJSTools.log('Enter YOCTagJSStorage.set() - sID: "' + a + '" - sKey: "' + c + '"');
            if (!YOCTagJSStorage.existsStorage(a)) {
                YOCTagJSTools.error('YOCTagJSStorage.set() - ID "' + a + '" does not exist');
                return null
            }
            this.aData[a][c] = b;
            return true
        } catch (d) {
            YOCTagJSTools.error("YOCTagJSStorage.set() Exception: " + d)
        }
    };
    YOCTagJSStorage = new YOCTagJSStorage()
}
var YOCTagJSBootstrap;
if (typeof (YOCTagJSBootstrap) == "undefined") {
    YOCTagJSBootstrap = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSBootstrap.constructor()")
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSBootstrap.constructor() Exception: " + a)
        }
    };
    YOCTagJSBootstrap.prototype.loadProviderConfig = function(a, b) {
        try {
            YOCTagJSTools.log("Enter YOCTagJSBootstrap.loadProviderConfig() - sID: " + a + " - sNextAction: " + b);
            sUseReference = YOCTagJSTools.determineReference(a);
            if (YOCTagJSConfig instanceof Object && typeof (YOCTagJSConfig[a]) != "undefined") {
                YOCTagJSConfig[a].next_action = b;
                YOCTagJSConfig[a].next_action_perform = false;
                YOCTagJSTools.log('YOCTagJSBootstrap.loadProviderConfig() - load config for reference - "' + sUseReference + '" (sID: "' + a + '")');
                YOCTagJSTools.loadScriptHead(YOCTagJSTools.sHostName + "/js/config." + sUseReference + ".js", this.onLoadProviderConfig, "")
            } else {
                YOCTagJSTools.error('YOCTagJSBootstrap.loadProviderConfig() - config not found for reference - "' + sUseReference + '" (sID: "' + a + '")')
            }
        } catch (c) {
            YOCTagJSTools.error("YOCTagJSBootstrap.loadProviderConfig() Exception: " + c)
        }
    };
    YOCTagJSBootstrap.prototype.onLoadProviderConfig = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSBootstrap.onLoadProviderConfig()");
            if (YOCTagJSProviderConfig instanceof Object) {
                for (var a in YOCTagJSProviderConfig) {
                    sReference = a;
                    sID = YOCTagJSTools.determineID(sReference);
                    if (YOCTagJSProviderConfig.hasOwnProperty(sReference)) {
                        oConfigValue = YOCTagJSProviderConfig[sReference];
                        YOCTagJSTools.extendConfig(sID, sReference, oConfigValue);
                        try {
                            YOCTagJSProviderConfig.splice(sReference, 1)
                        } catch (b) {
                            YOCTagJSTools.error('YOCTagJSBootstrap.onLoadProviderConfig() - Delete config failed - sConfigKey: "' + a + '" - sUseConfigKey: "' + sUseConfigKey + '" - Exception: ' + b)
                        }
                        if (YOCTagJSConfig[sID] instanceof Object && typeof (YOCTagJSConfig[sID].next_action) != "undefined" && YOCTagJSConfig[sID].next_action != "") {
                            YOCTagJSConfig[sID].next_action_perform = true
                        }
                        YOCTagJSBootstrap.run(sID)
                    }
                }
            } else {
                YOCTagJSTools.bIsError = true;
                YOCTagJSTools.error("YOCTagJSBootstrap.onLoadProviderConfig() - Invalid YOCTagJSProviderConfig")
            }
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSBootstrap.onLoadProviderConfig() Exception: " + b)
        }
    };
    YOCTagJSBootstrap.prototype.run = function(a) {
        try {
            YOCTagJSTools.log("Enter YOCTagJSBootstrap.run() - sID: " + a);
            sReference = YOCTagJSTools.determineReference(a);
            YOCTagJSTools.log('YOCTagJSBootstrap.run() - sID: "' + a + '" - sReference: "' + sReference + '" - Launch event "init_adspace" begin');
            YOCTagJSEvent.run("init_adspace", {id: a,reference: sReference});
            YOCTagJSTools.log('YOCTagJSBootstrap.run() - sID: "' + a + '" - sReference: "' + sReference + '" - Launch event "init_adspace" end');
            if (YOCTagJSConfig instanceof Object && typeof (YOCTagJSConfig[a]) != "undefined") {
                YOCTagJSTools.log('YOCTagJSBootstrap.run() - sID: "' + a + '" - sReference: "' + sReference + '" - ' + JSON.stringify(YOCTagJSConfig[a]));
                if (YOCTagJSConfig[a] instanceof Object && typeof (YOCTagJSConfig[a].next_action) != "undefined" && YOCTagJSConfig[a].next_action == "show" && typeof (YOCTagJSConfig[a].next_action_perform) != "undefined" && YOCTagJSConfig[a].next_action_perform) {
                    YOCTagJSTools.log('YOCTagJSBootstrap.run() - perform action "show" - sID: "' + a + '" - sReference: "' + sReference + '" - ' + JSON.stringify(YOCTagJSConfig[a]));
                    YOCTagJSConfig[a].next_action = "";
                    YOCTagJSConfig[a].next_action_perform = false;
                    new YOCTagJS(a)
                } else {
                    YOCTagJSTools.log('YOCTagJSBootstrap.run() - action not definied - sID: "' + a + '" - sReference: "' + sReference + '" - ' + JSON.stringify(YOCTagJSConfig[a]))
                }
            } else {
                YOCTagJSTools.error('YOCTagJSBootstrap.run() - unknown config ID - sID: "' + a + '" - sReference: "' + sReference + '"')
            }
        } catch (b) {
            YOCTagJSTools.error("YOCTagJSBootstrap.run() Exception: " + b)
        }
    };
    YOCTagJSBootstrap = new YOCTagJSBootstrap()
}
YOCTagJS = function(a) {
    try {
        YOCTagJSTools.log("");
        YOCTagJSTools.log("Enter YOCTagJS.constructor() - sID: " + a);
        if (a) {
            this.sID = a;
            this.sReference = YOCTagJSTools.determineReference(this.sID);
            YOCTagJSTools.log('YOCTagJS.constructor() - Use reference "' + this.sReference + '" for ID "' + this.sID + '"');
            if (!YOCTagJSStorage.existsStorage(this.sID)) {
                YOCTagJSStorage.addStorage(this.sID)
            }
            this.oConfigEnvironment = {};
            if (typeof (YOCTagJSConfig[a]) != "undefined") {
                this.oConfigEnvironment = YOCTagJSConfig[a]
            }
            if (!this.oConfigEnvironment || typeof (this.oConfigEnvironment.provider) == "undefined") {
                if (!YOCTagJSStorage.exists(this.sID, "config_load")) {
                    YOCTagJSTools.log('YOCTagJS.constructor() - Load provider config for reference "' + this.sReference + '" (ID "' + this.sID + '")');
                    YOCTagJSStorage.set(this.sID, "config_load", true);
                    YOCTagJSBootstrap.loadProviderConfig(this.sID, "show")
                } else {
                    YOCTagJSTools.error('YOCTagJS.constructor() - Load provider config FAILED for reference "' + this.sReference + '" (ID "' + this.sID + '")')
                }
            } else {
                this.bIsAJAX = false;
                if (typeof (this.oConfigEnvironment.container_id) != "undefined" && this.oConfigEnvironment.container_id != "") {
                    this.bIsAJAX = true
                }
                if (typeof (this.oConfigEnvironment.keyword) == "undefined" || this.oConfigEnvironment.keyword == "") {
                    this.oConfigEnvironment.keyword = {}
                }
                if (typeof (this.oConfigEnvironment.sequence) == "undefined" || this.oConfigEnvironment.sequence == "") {
                    this.oConfigEnvironment.sequence = "1"
                }
                if (typeof (this.oConfigEnvironment.container_id) == "undefined" || this.oConfigEnvironment.container_id == "") {
                    this.oConfigEnvironment.container_id = "YOCTagJS_adspace_container_" + this.sID
                }
                YOCTagJSTools.log("YOCTagJS.constructor() - sID: " + this.sID + " - oConfigEnvironment: " + JSON.stringify(this.oConfigEnvironment));
                YOCTagJSObjects[this.sID] = this;
                this.oYOCTagJSAdSpaceContainer = document.getElementById(this.oConfigEnvironment.container_id);
                if (!this.oYOCTagJSAdSpaceContainer && this.bIsAJAX) {
                    YOCTagJSTools.bIsError = true;
                    YOCTagJSTools.error('YOCTagJS - AJAX: Cannot determine container "' + this.oConfigEnvironment.container_id + '" for ID "' + this.sID + '"')
                }
                this.bIsAdSpaceContainerUserDefined = false;
                if (this.oYOCTagJSAdSpaceContainer) {
                    this.bIsAdSpaceContainerUserDefined = true
                }
                if (!YOCTagJSTools.bIsError) {
                    if (this.bIsAdSpaceContainerUserDefined) {
                        YOCTagJSObjects[this.sID].init()
                    } else {
                        YOCTagJSTools.documentWrite('<div id="' + this.oConfigEnvironment.container_id + '" reference="' + this.sReference + '"><script type="text/javascript">YOCTagJSObjects["' + this.sID + '"].init();<\/script></div>')
                    }
                } else {
                    YOCTagJSTools.error("YOCTagJS - Exit on error")
                }
            }
        } else {
            YOCTagJSTools.log('YOCTagJS - Exit - Invalid ID "' + a + '"')
        }
    } catch (b) {
        YOCTagJSTools.error("YOCTagJS.constructor() Exception: " + b)
    }
};
YOCTagJS.prototype.init = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJS.init() with sID: " + this.sID);
        if (!this.oYOCTagJSAdSpaceContainer) {
            YOCTagJSTools.log('YOCTagJS.init() - Determine container "' + this.oConfigEnvironment.container_id + '" for ID "' + this.sID + '"');
            this.oYOCTagJSAdSpaceContainer = document.getElementById(this.oConfigEnvironment.container_id);
            if (!this.oYOCTagJSAdSpaceContainer) {
                YOCTagJSTools.bIsError = true;
                YOCTagJSTools.error('YOCTagJS - Cannot determine container "' + this.oConfigEnvironment.container_id + '" for ID "' + this.sID + '"')
            }
        }
        if (!YOCTagJSTools.bIsError) {
            if (this.oConfigEnvironment && typeof (this.oConfigEnvironment.provider) != "undefined" && typeof (this.oConfigEnvironment.provider.name) != "undefined" && typeof (this.oConfigEnvironment.provider.config) != "undefined") {
                YOCTagJSTools.log("YOCTagJS.init() - Load provider: " + this.oConfigEnvironment.provider.name);
                this.loadProvider(this, this.oConfigEnvironment.provider.name, this.oConfigEnvironment.provider.config)
            } else {
                YOCTagJSTools.log("YOCTagJS.init() - No provider found for ID: " + this.sID)
            }
        } else {
            YOCTagJSTools.log("YOCTagJS.init() - Exit")
        }
    } catch (a) {
        YOCTagJSTools.error("YOCTagJS.init() Exception: " + a)
    }
};
YOCTagJS.prototype.loadProvider = function(a, c, b) {
    try {
        YOCTagJSTools.log("Enter YOCTagJS.loadProvider() sProvider: " + c + " - oConfigAdSpace: " + JSON.stringify(b) + " - oConfigEnvironment: " + JSON.stringify(this.oConfigEnvironment));
        if (c == "DFP") {
            YOCTagJSTools.log("YOCTagJS.loadProvider() load provider: " + c + " - oConfigAdSpace: " + JSON.stringify(b) + " - oConfigEnvironment: " + JSON.stringify(this.oConfigEnvironment));
            this.oYOCTagJSProviderDFP = new YOCTagJSProviderDFP(a, this.sID, b, this.oConfigEnvironment);
            this.oYOCTagJSProviderDFP.init()
        } else {
            if (c == "Smart") {
                YOCTagJSTools.log("YOCTagJS.loadProvider() load provider: " + c + " - oConfigAdSpace: " + JSON.stringify(b) + " - oConfigEnvironment: " + JSON.stringify(this.oConfigEnvironment));
                this.oYOCTagJSProviderSmart = new YOCTagJSProviderSmart(a, this.sID, b, this.oConfigEnvironment);
                this.oYOCTagJSProviderSmart.init()
            } else {
                YOCTagJSTools.log("YOCTagJS.loadProvider() unknown provider: " + c + " - oConfigAdSpace: " + JSON.stringify(b) + " - oConfigEnvironment: " + JSON.stringify(this.oConfigEnvironment))
            }
        }
    } catch (d) {
        YOCTagJSTools.error("YOCTagJS.loadProvider() Exception: " + d)
    }
};
YOCTagJSProviderDFP = function(g, d, f, b) {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderDFP.constructor() - sID: " + d + " - bIsAdSpaceContainerUserDefined: " + (g.bIsAdSpaceContainerUserDefined ? "TRUE" : "FALSE") + " - oConfigAdSpace: " + JSON.stringify(f) + " - oConfigEnvironment: " + JSON.stringify(b));
        this.oYOCTagJS = g;
        this.sID = d;
        this.oConfigAdSpace = f;
        this.oConfigEnvironment = b;
        YOCTagJSStorage.set(this.sID, "call_counter", YOCTagJSStorage.get(this.sID, "call_counter") + 1);
        if (typeof YOCTagJSStorageSystem.bIsLibraryLoadedGPTMobile == "undefined") {
            YOCTagJSStorageSystem.bIsLibraryLoadedGPTMobile = false
        }
        YOCTagJSTools.createChildAdSpaceContainer("" + this.oConfigAdSpace.divid + "", this.oYOCTagJS.sReference, this.oYOCTagJS.oYOCTagJSAdSpaceContainer, false, false, true);
        this.oAdSpaceContainer = document.getElementById(this.oConfigAdSpace.divid);
        this.oConfigAdSpace.unitcode = this.oConfigAdSpace.adspace;
        YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Determine targetings");
        this.oTargetingList = new Array();
        try {
            YOCTagJSTools.log('YOCTagJSProviderDFP.constructor() - Targetings - Keyword - INIT: "' + this.oConfigEnvironment.keyword + '"');
            if (this.oConfigEnvironment.keyword instanceof Object) {
                for (var a in this.oConfigEnvironment.keyword) {
                    if (this.oConfigEnvironment.keyword.hasOwnProperty(a)) {
                        sKeywordValue = this.oConfigEnvironment.keyword[a];
                        sKeywordKeyUse = a;
                        sKeywordValueUse = "";
                        if (sKeywordValue.indexOf(",") > -1) {
                            sKeywordValueList = sKeywordValue.split(",");
                            for (var h in sKeywordValueList) {
                                if (sKeywordValueList.hasOwnProperty(h)) {
                                    sValue = sKeywordValueList[h];
                                    sValue = sValue.trim();
                                    sValue = sValue.toLowerCase();
                                    if (sValue.length > 0) {
                                        if (sKeywordValueUse.length > 0) {
                                            sKeywordValueUse += ", "
                                        }
                                        sKeywordValueUse += '"' + sValue + '"'
                                    }
                                }
                            }
                            if (sKeywordValueUse.length > 0) {
                                sKeywordValueUse = "[" + sKeywordValueUse + "]"
                            }
                        } else {
                            if (sKeywordValue.length > 0) {
                                sKeywordValueUse = '"' + sKeywordValue + '"'
                            }
                        }
                        if (sKeywordValueUse.length > 0) {
                            this.oTargetingList[sKeywordKeyUse] = sKeywordValueUse;
                            YOCTagJSTools.log('YOCTagJSProviderDFP.constructor() - Targetings - Keyword - ADD: "' + sKeywordKeyUse + '": ' + sKeywordValueUse + "")
                        } else {
                            YOCTagJSTools.log('YOCTagJSProviderDFP.constructor() - Targetings - Keyword - IGNORE empty keyword: "' + sKeywordKeyUse + '": ' + sKeywordValueUse + "")
                        }
                    }
                }
            } else {
                if (this.oConfigEnvironment.keyword != "") {
                    YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Targetings - Keyword - Single keyword without identifier NOT supported!")
                }
            }
            YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Targetings - Keyword - DONE")
        } catch (c) {
            YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Targetings - Keyword - Exception: " + i)
        }
        YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Determine adspace size(s) - oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace));
        this.sAdSpaceSize = "[]";
        if (typeof (this.oConfigAdSpace) == "object") {
            if (typeof (this.oConfigAdSpace.size) == "object") {
                YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - Check size list: " + JSON.stringify(this.oConfigAdSpace.size));
                this.sAdSpaceSize = "";
                for (var e in this.oConfigAdSpace.size) {
                    if (this.oConfigAdSpace.size.hasOwnProperty(e)) {
                        oSizeValue = this.oConfigAdSpace.size[e];
                        YOCTagJSTools.log('YOCTagJSProviderDFP.constructor() - Found size in list - "' + e + '": ' + JSON.stringify(oSizeValue));
                        if (this.sAdSpaceSize.length > 0) {
                            this.sAdSpaceSize += ", "
                        }
                        this.sAdSpaceSize += "[" + oSizeValue.width + "," + oSizeValue.height + "]"
                    }
                }
                this.sAdSpaceSize = "[" + this.sAdSpaceSize + "]"
            } else {
                if (typeof (this.oConfigAdSpace.width) != "undefined" && typeof (this.oConfigAdSpace.height) != "undefined") {
                    YOCTagJSTools.log('YOCTagJSProviderDFP.constructor() - Found size - "' + this.oConfigAdSpace.width + '" x "' + this.oConfigAdSpace.height + '"');
                    this.sAdSpaceSize = "[" + this.oConfigAdSpace.width + ", " + this.oConfigAdSpace.height + "]"
                }
            }
        }
        YOCTagJSTools.log("YOCTagJSProviderDFP.constructor() - CallCounter: " + YOCTagJSStorage.get(this.sID, "call_counter") + " - sAdSpaceSize: " + this.sAdSpaceSize + " - oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace))
    } catch (i) {
        YOCTagJSTools.error("YOCTagJSProviderDFP.constructor() Exception: " + i)
    }
};
YOCTagJSProviderDFP.prototype.onLoadDFP = function(b) {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderDFP.onLoadDFP()");
        sReference = null;
        if (typeof this.reference != "undefined") {
            sReference = this.reference
        } else {
            if (typeof this.sID != "undefined") {
                sReference = this.sID
            } else {
                if (typeof (b) == "object" && typeof b.reference != "undefined") {
                    sReference = b.reference
                }
            }
        }
        sID = YOCTagJSTools.determineID(sReference);
        YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - sID: "' + sID + '" - sReference: "' + sReference + '"');
        oYOCTagJS = YOCTagJSObjects[sID];
        YOCTagJSTools.log("YOCTagJSProviderDFP.onLoadDFP() - oConfigAdSpace: " + JSON.stringify(oYOCTagJS.oYOCTagJSProviderDFP.oConfigAdSpace));
        if (!YOCTagJSStorage.exists(sID, "ad_slot")) {
            YOCTagJSTools.log("YOCTagJSProviderDFP.onLoadDFP() - Enable services");
            YOCTagJSStorage.set(sID, "ad_slot", new Array());
            sScriptSetTargeting = "";
            if (this.oTargetingList instanceof Object) {
                sScriptSetTargeting += "\r\n				YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Try to set targeting ');\r\n				\r\n				if (YOCTagJSStorage.exists(\"" + sID + '", "ad_slot")) {\r\n					oAdSlotList = YOCTagJSStorage.get("' + sID + '", "ad_slot");\r\n					\r\n					for (var sAdSlotKey in oAdSlotList) {\r\n						if (oAdSlotList.hasOwnProperty(sAdSlotKey)) {\r\n							oAdSlotValue = oAdSlotList[sAdSlotKey];\r\n							';
                for (var a in this.oTargetingList) {
                    if (this.oTargetingList.hasOwnProperty(a)) {
                        sTargetingValue = this.oTargetingList[a];
                        sScriptSetTargeting += "\r\n							\r\n							YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Set targeting in ad slot \"" + a + '": ' + sTargetingValue + "');\r\n							oAdSlotValue.setTargeting(\"" + a + '", ' + sTargetingValue + ");"
                    }
                }
                sScriptSetTargeting += "\r\n						}\r\n					}\r\n				}"
            }
            oScript = document.createElement("script");
            oScript.type = "text/javascript";
            oScript.reference = sReference;
            oScript.innerHTML = "\r\n	googletag.cmd.push(\r\n			function() {\r\n				YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Create slot: ' + YOCTagJSObjects[\"" + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.unitcode);\r\n				\r\n				YOCTagJSStorage.get("' + sID + '", "ad_slot").push(googletag.defineSlot(YOCTagJSObjects["' + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.unitcode, ' + this.sAdSpaceSize + ', YOCTagJSObjects["' + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.divid).addService(googletag.pubads()));\r\n				' + sScriptSetTargeting + "\r\n				\r\n				if (YOCTagJSTools.bRenderingAsynchronous) {\r\n					YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Enable asynchronous rendering');\r\n					\r\n					googletag.pubads().enableAsyncRendering();\r\n				}\r\n				\r\n				YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Enable google services');\r\n				\r\n				googletag.enableServices();\r\n			}\r\n		);";
            YOCTagJSTools.oHead.appendChild(oScript);
            YOCTagJSTools.log("YOCTagJSProviderDFP.onLoadDFP() - Display ad");
            oScript = document.createElement("script");
            oScript.type = "text/javascript";
            oScript.reference = sReference;
            oScript.innerHTML = "\r\n	googletag.cmd.push(\r\n			function() {\r\n				YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Display: ' + YOCTagJSObjects[\"" + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.divid);\r\n				\r\n				googletag.display(YOCTagJSObjects["' + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.divid);\r\n			}\r\n		);';
            this.oAdSpaceContainer.appendChild(oScript)
        } else {
            YOCTagJSTools.log("YOCTagJSProviderDFP.onLoadDFP() - Refresh ad");
            oAdSlot = YOCTagJSStorage.get(sID, "ad_slot");
            if (oAdSlot instanceof Object) {
                for (var c in oAdSlot) {
                    if (oAdSlot.hasOwnProperty(c)) {
                        oAdSlotValue = oAdSlot[c];
                        oScript = document.createElement("script");
                        oScript.type = "text/javascript";
                        oScript.reference = sReference;
                        oScript.innerHTML = "	googletag.cmd.push(			function() {				YOCTagJSTools.log('YOCTagJSProviderDFP.onLoadDFP() - Refresh - AdSlot: \"" + c + '" - DIV: \' + YOCTagJSObjects["' + sID + '"].oYOCTagJSProviderDFP.oConfigAdSpace.divid);								googletag.pubads().refresh([YOCTagJSStorage.get("' + sID + '", "ad_slot")["' + c + '"]]);			}		);';
                        this.oAdSpaceContainer.appendChild(oScript)
                    }
                }
            }
        }
        if (YOCTagJSTools.bInvalidateContainer) {
            YOCTagJSTools.log("YOCTagJSProviderDFP.onLoadDFP() - Invalidate container!");
            this.oYOCTagJS.oYOCTagJSAdSpaceContainer.id = YOCTagJSTools.sInvalidAdSpaceContainerPrefix + sReference
        }
    } catch (d) {
        YOCTagJSTools.error("YOCTagJSProviderDFP.onLoadDFP() Exception: " + d)
    }
};
YOCTagJSProviderDFP.prototype.init = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderDFP.init()");
        this.loadLibraries()
    } catch (a) {
        YOCTagJSTools.error("YOCTagJSProviderDFP.init() Exception: " + a)
    }
};
YOCTagJSProviderDFP.prototype.loadLibraries = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderDFP.loadLibraries()");
        sReference = null;
        if (typeof this.reference != "undefined") {
            sReference = this.reference
        } else {
            if (typeof this.sID != "undefined") {
                sReference = this.sID
            }
        }
        sID = YOCTagJSTools.determineID(sReference);
        YOCTagJSTools.log('YOCTagJSProviderDFP.loadLibraries() - sID: "' + sID + '" - sReference: "' + sReference + '"');
        if (typeof googletag != "undefined") {
            YOCTagJSStorageSystem.bIsLibraryLoadedGPTMobile = true
        }
        if (YOCTagJSStorageSystem.bIsLibraryLoadedGPTMobile) {
            YOCTagJSTools.log("YOCTagJSProviderDFP.loadLibraries() - All libraries loaded!");
            YOCTagJSObjects[sID].oYOCTagJSProviderDFP.onLoadDFP()
        } else {
            if (!YOCTagJSStorageSystem.bIsLibraryLoadedGPTMobile) {
                YOCTagJSTools.log('YOCTagJSProviderDFP.loadLibraries() - Load "gpt_mobile.js"');
                YOCTagJSTools.loadScriptHead("www.googletagservices.com/tag/js/gpt_mobile.js", YOCTagJSObjects[sID].oYOCTagJSProviderDFP.loadLibraries, sReference)
            } else {
                YOCTagJSTools.error("YOCTagJSProviderDFP.loadLibraries() - load libraries failed")
            }
        }
    } catch (a) {
        YOCTagJSTools.error("YOCTagJSProviderDFP.loadLibraries() Exception: " + a)
    }
};
YOCTagJSProviderSmart = function(a, b, d, c) {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderSmart.constructor() - sID: " + b + " - bIsAdSpaceContainerUserDefined: " + (a.bIsAdSpaceContainerUserDefined ? "TRUE" : "FALSE") + " oConfigAdSpace: " + JSON.stringify(d) + " - oConfigEnvironment: " + JSON.stringify(c));
        this.oYOCTagJS = a;
        this.sID = b;
        this.oConfigAdSpace = d;
        this.oConfigEnvironment = c;
        this.oConfigAdSpace.sas_target = this.oConfigAdSpace.keyword;
        this.oConfigAdSpace.sas_pageid = this.oConfigAdSpace.site + "/" + this.oConfigAdSpace.adspace;
        this.oConfigAdSpace.sas_formatid = this.oConfigAdSpace.format;
        YOCTagJSStorage.set(this.sID, "call_counter", YOCTagJSStorage.get(this.sID, "call_counter") + 1);
        YOCTagJSTools.log("YOCTagJSProviderSmart.constructor() - CallCounter: " + YOCTagJSStorage.get(this.sID, "call_counter") + " - oConfigAdSpace: " + this.oConfigAdSpace)
    } catch (e) {
        YOCTagJSTools.error("YOCTagJSProviderSmart.constructor() Exception: " + e)
    }
};
YOCTagJSProviderSmart.prototype.onLoadSmart = function(a) {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderSmart.onLoadSmart()");
        sReference = null;
        if (typeof this.reference != "undefined") {
            sReference = this.reference
        } else {
            if (typeof this.sID != "undefined") {
                sReference = this.sID
            } else {
                if (typeof (a) == "object" && typeof a.reference != "undefined") {
                    sReference = a.reference
                }
            }
        }
        sID = YOCTagJSTools.determineID(sReference);
        YOCTagJSTools.log('YOCTagJSProviderSmart.onLoadSmart() - sID: "' + sID + '" - sReference: "' + sReference + '"');
        oYOCTagJS = YOCTagJSObjects[sID];
        YOCTagJSTools.log("YOCTagJSProviderSmart.onLoadSmart() - oConfigAdSpace: " + JSON.stringify(oYOCTagJS.oYOCTagJSProviderSmart.oConfigAdSpace));
        if (oYOCTagJS.bIsAJAX) {
            sasmobile(oYOCTagJS.oYOCTagJSProviderSmart.oConfigAdSpace.sas_pageid, oYOCTagJS.oYOCTagJSProviderSmart.oConfigAdSpace.sas_formatid, oYOCTagJS.oYOCTagJSProviderSmart.oConfigAdSpace.sas_target);
            if (YOCTagJSTools.bInvalidateContainer) {
                YOCTagJSTools.log("YOCTagJSProviderSmart.onLoadSmart() - Invalidate container!");
                oYOCTagJS.oYOCTagJSAdSpaceContainer.id = YOCTagJSTools.sInvalidAdSpaceContainerPrefix + sReference
            }
        } else {
        }
    } catch (b) {
        YOCTagJSTools.error("YOCTagJSProviderSmart.onLoadSmart() Exception: " + b)
    }
};
YOCTagJSProviderSmart.prototype.init = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderSmart.init()");
        YOCTagJSTools.log("YOCTagJSProviderSmart.init() - OLD oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace));
        if (YOCTagJSTools.bRenderingAsynchronous) {
            YOCTagJSTools.log("YOCTagJSProviderSmart.init() - Ignore flag for asynchronous rendering")
        }
        this.oConfigAdSpace.sas_tmstp = Math.round(Math.random() * 10000000000);
        YOCTagJSTools.log('YOCTagJSProviderSmart.init() - Keyword - INIT: "' + this.oConfigAdSpace.sas_target + '"');
        if (this.oConfigEnvironment.keyword instanceof Object) {
            for (var a in this.oConfigEnvironment.keyword) {
                if (this.oConfigEnvironment.keyword.hasOwnProperty(a)) {
                    sKeywordValue = this.oConfigEnvironment.keyword[a];
                    if (this.oConfigAdSpace.sas_target != "") {
                        this.oConfigAdSpace.sas_target += ";"
                    }
                    this.oConfigAdSpace.sas_target += a + "=" + sKeywordValue;
                    YOCTagJSTools.log('YOCTagJSProviderSmart.init() - Keyword - ADD: "' + a + '": "' + sKeywordValue + '" - NOW: "' + this.oConfigAdSpace.sas_target + '"')
                }
            }
        } else {
            if (this.oConfigEnvironment.keyword != "") {
                if (this.oConfigAdSpace.sas_target != "") {
                    this.oConfigAdSpace.sas_target += ";"
                }
                this.oConfigAdSpace.sas_target += this.oConfigEnvironment.keyword;
                YOCTagJSTools.log('YOCTagJSProviderSmart.init() - Keyword - ADD: "' + this.oConfigEnvironment.keyword + '" - NOW: "' + this.oConfigAdSpace.sas_target + '"')
            }
        }
        YOCTagJSTools.log('YOCTagJSProviderSmart.init() - Keyword - FINAL: "' + this.oConfigAdSpace.sas_target + '"');
        this.oConfigAdSpace.sas_masterflag = 1;
        if (this.oConfigEnvironment.sequence != "1") {
            this.oConfigAdSpace.sas_masterflag = 0
        }
        YOCTagJSTools.log("YOCTagJSProviderSmart.init() - NEW oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace));
        YOCTagJSTools.createChildAdSpaceContainer("sas_" + this.oConfigAdSpace.sas_formatid + "", this.oYOCTagJS.sReference, this.oYOCTagJS.oYOCTagJSAdSpaceContainer, true, true, false);
        if (this.oYOCTagJS.bIsAJAX) {
            if (typeof (sasmobile) == "undefined") {
                YOCTagJSTools.loadScriptHead("cdn1.smartadserver.com/diff/js/sasmobile.js", this.onLoadSmart, this.oYOCTagJS.sReference)
            } else {
                this.onLoadSmart()
            }
        } else {
            this.sasmobile(this.oConfigAdSpace.sas_pageid, this.oConfigAdSpace.sas_formatid, this.oConfigAdSpace.sas_target);
            if (YOCTagJSTools.bInvalidateContainer) {
                YOCTagJSTools.log("YOCTagJSProviderSmart.init() - Invalidate container!");
                this.oYOCTagJS.oYOCTagJSAdSpaceContainer.id = YOCTagJSTools.sInvalidAdSpaceContainerPrefix + this.oYOCTagJS.sReference
            }
        }
    } catch (b) {
        YOCTagJSTools.error("YOCTagJSProviderSmart.init() Exception: " + b)
    }
};
YOCTagJSProviderSmart.prototype.sasmobile = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderSmart.sasmobile() - oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace));
        if (this.oConfigAdSpace.sas_masterflag == 1) {
            this.oConfigAdSpace.sas_masterflag = 0;
            this.oConfigAdSpace.sas_master = "M"
        } else {
            this.oConfigAdSpace.sas_master = "S"
        }
        YOCTagJSTools.loadScriptDirect("www4.smartadserver.com/call2/pubmj/" + this.oConfigAdSpace.sas_pageid + "/" + this.oConfigAdSpace.sas_formatid + "/" + this.oConfigAdSpace.sas_master + "/" + this.oConfigAdSpace.sas_tmstp + "/" + escape(this.oConfigAdSpace.sas_target) + "?", "YOCTagJSObjects['" + this.sID + "'].oYOCTagJSProviderSmart.onLoadSmart(this);", this.oYOCTagJS.sReference)
    } catch (a) {
        YOCTagJSTools.error("YOCTagJSProviderSmart.sasmobile() Exception: " + a)
    }
};
YOCTagJSProviderSmart.prototype.sascc = function() {
    try {
        YOCTagJSTools.log("Enter YOCTagJSProviderSmart.sascc() - oConfigAdSpace: " + JSON.stringify(this.oConfigAdSpace));
        img = new Image();
        img.src = "" + (this.bIsHTTPS ? "https" : "http") + "://www4.smartadserver.com/h/mcp?imgid=" + this.oConfigAdSpace.sas_imageid + "&pgid=" + this.oConfigAdSpace.sas_pageid + "&uid=[uid]&tmstp=" + this.oConfigAdSpace.sas_tmstp + "&tgt=[targeting]"
    } catch (a) {
        YOCTagJSTools.error("YOCTagJSProviderSmart.sascc() Exception: " + a)
    }
};
var YOCTagJSObjects;
if (typeof (YOCTagJSObjects) == "undefined") {
    YOCTagJSObjects = new Array()
}
var YOCTagJSConfigSystem;
if (typeof (YOCTagJSConfigSystem) == "undefined") {
    YOCTagJSConfigSystem = {}
}
var YOCTagJSConfig;
if (typeof (YOCTagJSConfig) == "undefined") {
    YOCTagJSConfig = {}
}
var YOCTagJSStorageSystem;
if (typeof (YOCTagJSStorageSystem) == "undefined") {
    YOCTagJSStorageSystem = {}
}
var YOCTagJSProviderConfig;
if (typeof (YOCTagJSProviderConfig) == "undefined") {
    YOCTagJSProviderConfig = new Array()
}
var YOCTagJSLibrary;
if (typeof (YOCTagJSLibrary) != "object") {
    YOCTagJSLibrary = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSLibrary.constructor()");
            this.init()
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSLibrary.constructor() Exception: " + a)
        }
    };
    YOCTagJSLibrary.prototype.init = function() {
        try {
            YOCTagJSTools.log("Enter YOCTagJSLibrary.init()");
            this.bIsLibraryLoadedYOCTagJSTools = false;
            this.bIsLibraryLoadedYOCTagJSEvent = false;
            this.bIsLibraryLoadedYOCTagJSStorage = false;
            this.bIsLibraryLoadedYOCTagJSBootstrap = false;
            this.bIsLibraryLoadedYOCTagJS = false;
            this.bIsLibraryLoadedYOCTagJSProviderDFP = false;
            this.bIsLibraryLoadedYOCTagJSProviderSmart = false;
            if (typeof (YOCTagJSTools) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSTools = true
            }
            if (typeof (YOCTagJSEvent) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSEvent = true
            }
            if (typeof (YOCTagJSStorage) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSStorage = true
            }
            if (typeof (YOCTagJSBootstrap) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSBootstrap = true
            }
            if (typeof (YOCTagJS) != "undefined") {
                this.bIsLibraryLoadedYOCTagJS = true
            }
            if (typeof (YOCTagJSProviderDFP) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSProviderDFP = true
            }
            if (typeof (YOCTagJSProviderSmart) != "undefined") {
                this.bIsLibraryLoadedYOCTagJSProviderSmart = true
            }
            if (this.bIsLibraryLoadedYOCTagJSTools && this.bIsLibraryLoadedYOCTagJSEvent && this.bIsLibraryLoadedYOCTagJSStorage && this.bIsLibraryLoadedYOCTagJSBootstrap && this.bIsLibraryLoadedYOCTagJS && this.bIsLibraryLoadedYOCTagJSProviderDFP && this.bIsLibraryLoadedYOCTagJSProviderSmart) {
                YOCTagJSTools.log("YOCTagJSLibrary.init() - load libraries done");
                YOCTagJSTools.log('YOCTagJSLibrary.init() - Launch event "init" begin');
                YOCTagJSEvent.run("init", {});
                YOCTagJSTools.log('YOCTagJSLibrary.init() - Launch event "init" end')
            } else {
                YOCTagJSTools.bIsError = true;
                YOCTagJSTools.error("YOCTagJSLibrary.init() - load libraries failed")
            }
        } catch (a) {
            YOCTagJSTools.error("YOCTagJSLibrary.init() Exception: " + a)
        }
    };
    YOCTagJSLibrary = new YOCTagJSLibrary()
}
YOCTagJSTools.extendConfig("", "", {});
