String.format = function(format) {
	var args = Array.prototype.slice.call(arguments, 1);
	return format.replace(/{(\d+)}/g, function(match, number) { 
		return typeof args[number] != 'undefined'
			? args[number] 
			: match
		;
	});
};

const loadingStages = ["Pre-map", "Map", "Post-map", "Session"];
const technicalNames = ["INIT_BEFORE_MAP_LOADED", "MAP", "INIT_AFTER_MAP_LOADED", "INIT_SESSION"];

var currentLoadingStage = 0;
var loadingWeights = [1.5/10, 4/10, 1.5/10, 3/10];

var loadingTotals = [70, 70, 70, 220];
var registeredTotals = [0, 0, 0, 0];
var stageVisible = [false, false, false, false];

var currentProgress = [0.0, 0.0, 0.0, 0.0];
var currentProgressSum = 0.0;
var currentLoadingCount = 0;

var minScale = 1.03
var maxScale = 2.00
var diffScale = maxScale - minScale
var backgroundPositionEnd = [200, 150];

function doProgress(stage) {
	var idx = technicalNames.indexOf(stage);

	if (idx >= 0) {
		registeredTotals[idx]++;

		if (idx > currentLoadingStage) {
			while (currentLoadingStage < idx) {
				currentProgress[currentLoadingStage] = 1.0;
				currentLoadingStage++;
			}

			currentLoadingCount = 1;
		}

		currentLoadingCount++;
		currentProgress[currentLoadingStage] = Math.min(currentLoadingCount/loadingTotals[idx], 1.0);
		updateProgress();
	}
}

const totalWidth = 99.1;

var progressPositions = [];
var progressMaxLengths = [];

progressPositions[0] = 0.0;

var i = 0;

while (i < currentProgress.length) {
	progressMaxLengths[i] = loadingWeights[i] * totalWidth;
	progressPositions[i+1] = progressPositions[i] + progressMaxLengths[i];
	i++;
}

function getRandomInt(max) {
	return Math.floor(Math.random() * Math.floor(max));
}

var backgrounds = [
	"https://www.igta5.com/images/official-screenshot-gold-luxor-deluxe.jpg",
	"https://www.igta5.com/images/official-screenshot-gold-combat-pdw.jpg",
	"https://www.igta5.com/images/official-screenshot-virgo-sunset.jpg",
	"https://www.igta5.com/images/official-screenshot-cant-touch-this.jpg",
	"https://www.igta5.com/images/official-screenshot-classy-windsor.jpg",
	"https://www.igta5.com/images/official-screenshot-shake-dat-ass.jpg",
	"https://www.igta5.com/images/official-screenshot-osiris-tearing-rubber.jpg",
	"https://www.igta5.com/images/official-screenshot-gold-swift-deluxe.jpg",
	"https://www.igta5.com/images/official-screenshot-future-content.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-cape-catfish.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-wants-that-one.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-vinewood-cars.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-alamo-sea.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-cleaning-house.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-downtown-dusk.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-franklin-takes-option-b.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-in-the-desert.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-vinewood-blvd.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-getting-higher.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-in-the-woods.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-castle-in-the-hills.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-michael-on-the-phone.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-lighthouse.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-dodging-the-law.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-snap-at-the-moon.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-franklin-calls-michael.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-lightning-snipe.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-trevor-checks-the-kitchen.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-franklin-has-blue-balls.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-sunrise-in-grapeseed.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-up-to-no-good.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-escaping-with-the-jewels.jpg",
	"https://www.igta5.com/images/official-screenshot-pc-spring-stream.jpg",
]

function updateBackground() {
	$('#background').fadeOut(1000)

	setTimeout(function() {
		$('#background').css("background-image", "url(" + backgrounds[parseInt(getRandomInt(parseInt(backgrounds.length - 1)))] + ")");
	}, 1000)

	setTimeout(function() {
		$('#background').fadeIn(1000)
	}, 3500)

	setTimeout(function() {
		updateBackground()
	}, 10000)
}

updateBackground()

function updateProgress() {
	var i = 0;

	while (i <= currentLoadingStage) {
		if ((currentProgress[i] > 0 || !currentProgress[i-1]) && !stageVisible[i]) {
			document.querySelector("#" + technicalNames[i]+"-label").style.display = 'inline-block';
			document.querySelector("#" + technicalNames[i]+"-bar").style.display = 'inline-block';

			stageVisible[i] = true;
		}

		document.querySelector("#" + technicalNames[i]+"-bar").style.width = currentProgress[i]*progressMaxLengths[i] + '%';
		document.querySelector("#" + technicalNames[i]+"-label").style.width = progressMaxLengths[i] + '%';

		i++;
	}
}

updateProgress();

var count = 0;
var thisCount = 0;

const gstate = {
	elems: [],
	log: []
};

function printLog(type, str) {
	//gstate.log.push({ type: type, str: str });
};

const handlers = {
	startInitFunction(data) {
		gstate.elems.push({
			name: data.type,
			orders: []
		});

		printLog(1, String.format('Running {0} init functions', data.type));
		if(data.type) doProgress(data.type);
	},

	startInitFunctionOrder(data) {
		count = data.count;
		printLog(1, String.format('[{0}] Running functions of order {1} ({2} total)', data.type, data.order, data.count));
		if(data.type) doProgress(data.type);
	},

	initFunctionInvoking(data) {
		printLog(3, String.format('Invoking {0} {1} init ({2} of {3})', data.name, data.type, data.idx, count));
		if(data.type) doProgress(data.type);
	},

	initFunctionInvoked(data) {
		if(data.type) doProgress(data.type);
	},

	endInitFunction(data) {
		printLog(1, String.format('Done running {0} init functions', data.type));
		if(data.type) doProgress(data.type);
	},

	startDataFileEntries(data) {
		count = data.count;

		printLog(1, 'Loading map');
		if(data.type) doProgress(data.type);
	},

	onDataFileEntry(data) {
		printLog(3, String.format('Loading {0}', data.name));
		doProgress(data.type);
		if(data.type) doProgress(data.type);
	},

	endDataFileEntries() {
		printLog(1, 'Done loading map');
	},

	performMapLoadFunction(data) {
		doProgress('MAP');
	},

	onLogLine(data) {
		printLog(3, data.message);
	}
};

setInterval(function(){document.querySelector('#log').innerHTML = gstate.log.slice(-10).map(function(e){return String.format("[{0}] {1}", e.type, e.str)}).join('<br />');}, 100);

window.addEventListener('message', function(e) {
	(handlers[e.data.eventName] || function() {})(e.data);
});

if (!window.invokeNative) {
	var newType = function newType(name) {
		return function () {
			return handlers.startInitFunction({ type: name });
		};
	};

	var newOrder = function newOrder(name, idx, count) {
		return function () {
			return handlers.startInitFunctionOrder({ type: name, order: idx, count: count });
		};
	};

	var newInvoke = function newInvoke(name, func, i) {
		return function () {
			handlers.initFunctionInvoking({ type: name, name: func, idx: i });handlers.initFunctionInvoked({ type: name });
		};
	};

	var startEntries = function startEntries(count) {
		return function () {
			return handlers.startDataFileEntries({ count: count });
		};
	};

	var addEntry = function addEntry() {
		return function () {
			return handlers.onDataFileEntry({ name: 'meow', isNew: true });
		};
	};

	var stopEntries = function stopEntries() {
		return function () {
			return handlers.endDataFileEntries({});
		};
	};

	var newTypeWithOrder = function newTypeWithOrder(name, count) {
		return function () {
			newType(name)();newOrder(name, 1, count)();
		};
	};

	const demoFuncs = [
		newTypeWithOrder('MAP', 5),
		newInvoke('MAP', 'meow1', 1),
		newInvoke('MAP', 'meow2', 2),
		newInvoke('MAP', 'meow3', 3),
		newInvoke('MAP', 'meow4', 4),
		newInvoke('MAP', 'meow5', 5),
		newOrder('MAP', 2, 2),
		newInvoke('MAP', 'meow1', 1),
		newInvoke('MAP', 'meow2', 2),
		startEntries(6),
		addEntry(),
		addEntry(),
		addEntry(),
		addEntry(),
		addEntry(),
		addEntry(),
		stopEntries(),
		newTypeWithOrder('INIT_SESSION', 4),
		newInvoke('INIT_SESSION', 'meow1', 1),
		newInvoke('INIT_SESSION', 'meow2', 2),
		newInvoke('INIT_SESSION', 'meow3', 3),
		newInvoke('INIT_SESSION', 'meow4', 4),
	];

	setInterval(function(){ demoFuncs.length && demoFuncs.shift()();}, 350);
}
