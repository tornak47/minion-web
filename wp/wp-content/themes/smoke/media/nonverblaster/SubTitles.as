﻿package nonverblaster {		import flash.events.IOErrorEvent;	import flash.display.Sprite;	import flash.display.MovieClip;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.net.*;	import flash.filters.DropShadowFilter;	import flash.filters.BitmapFilterQuality;	public class SubTitles extends Sprite{				private var fileData		:String;		public var xmlData			:XML;		private var url				:String;		private var currentText		:String;		private var main			:MovieClip;		private var playTime		:Number;		private var tField			:SubTitleField;		public var plainXML			:XML;		public var enabled			:Boolean = true;				public function SubTitles($main){			main = $main;			createField();			setFilter();			mouseEnabled = false;			tField.mouseEnabled = false;			Glo.bal.subTitles = this;			//drawBack();		}		private function drawBack(){			var back:Sprite = new Sprite();			addChildAt(back, 0);			var b = back.graphics;			b.beginFill(0xffffff);			b.drawRect(0,0,1000,1000);			b.endFill();			back.mouseEnabled = false;		}		private function setFilter(){			var effect:DropShadowFilter = new DropShadowFilter();			effect.blurX = effect.blurY = 1.5;			effect.color = 0x000000;			effect.distance = 1;			effect.angle = 130;			effect.quality = BitmapFilterQuality.HIGH;			effect.strength = 1.5;						var filterArray:Array = new Array();			filterArray.push(effect);			tField.filters = filterArray;		}		private function createField(){			tField = new SubTitleField();			addChild(tField);		}		public function loopIt(){			playTime = main.getTime();			if(!isNaN(playTime)){				try { checkForTitle() } catch (e:Error){};			}		}		public function fit(){			tField.x = Glo.bal.stageWidth / 2 - tField.width / 2;			tField.textFeld.width = Glo.bal.stageWidth - 40;			if(Glo.bal.subtitlePosition == "top"){				tField.y = 20;			} else {				tField.y = Glo.bal.control.y - 15 - tField.height;			}		}		private function checkForTitle(){			var titleFound:Boolean = false;			for(var i:uint = 0; i<xmlData.p.length(); i++){				var p = xmlData.p[i];				if(p.@begin <= playTime && p.@end >= playTime){					showText(p.toString());					titleFound = true;					break;				}			}			if(titleFound != true){				showText("");			}		}		public function showText($t){			if($t != currentText) {				currentText = $t;				tField.setText(currentText);				fit();			}		}		public function load($url){			url = $url;			var urlLoader:URLLoader = new URLLoader();			urlLoader.addEventListener(Event.COMPLETE, xmlCompleteHandler, false, 0, true);			urlLoader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );			urlLoader.load(new URLRequest(url));		}		private function ioErrorHandler( e:IOErrorEvent ):void {			trace(this + ": " + e.text);		}		private function xmlCompleteHandler(event:Event):void {			fileData = event.target.data;			plainXML = xmlData = getPlainXML();			prepareXML();			dispatchEvent(new Event("complete"));			Glo.bal.contextMenu.addSubsItem();		}		private function getPlainXML() : XML{			if(url.substring(url.lastIndexOf(".")) == ".srt"){				xmlData = convertSrtToXML();			} else {				xmlData = XML(fileData);			}			return xmlData;		}		private function convertSrtToXML():XML{			var srtData:String = fileData.toString().split("\r").join("");			var linesArray:Array = srtData.split("\n");			//var xmlString:String = '<tt xml:lang="en" xmlns="http://www.w3.org/2006/10/ttaf1" xmlns:tts="http://www.w3.org/2006/10/ttaf1#style">'			var xmlString:String = '<tt>';			xmlString += '\n\t<head>';    		xmlString += '\n\t\t<layout />'  			xmlString += '\n\t</head>';			xmlString += '\n\t<body>';			xmlString += '\n\t\t<div id="captions">\n';						var lineStrings:Array = new Array();			for(var i:uint = 0; i<linesArray.length; i++){				var line:String = linesArray[i];				var lineString = "";				if(i > 0 && linesArray[i-1].length > 0) {					if(line.indexOf("-->") != -1){						var begin = line.split("-->")[0].split(",").join(".").split(" ").join("");						var end = line.split("-->")[1].split(",").join(".").split(" ").join("");						lineString += '\t\t\t<p begin="' + begin + '" end="' + end + '">';					} else if(linesArray[i].length != 0) {						lineString += line;						if(linesArray[i+1].length > 0){							lineString += "<br />";						} else {							lineString += "</p>\n";						}					}				}				xmlString += lineString;			}			xmlString += '\n\t\t</div>';			xmlString += '\n\t</body>';			xmlString += '\n</tt>';						return XML(xmlString);		}		private function prepareXML() {			xmlData = XML(xmlData.body.div);			for(var i:uint = 0; i<xmlData.p.length(); i++){				var p = xmlData.p[i];				p.@begin = convertToSeconds(p.@begin);				p.@end = convertToSeconds(p.@end);			}		}		private function convertToSeconds(string:String):Number {			var n:Number;			var split:Array = string.split(":");			n = Number(split[0]) * 3600 + Number(split[1]) * 60 + Number(split[2]);			return n;		}		public function toggleSubs(){			visible = !visible;			if(visible == true){				Glo.bal.contextMenu.subsItem1.caption = "disable SubTitles";			} else {				Glo.bal.contextMenu.subsItem1.caption = "enable SubTitles";			}		}	}}