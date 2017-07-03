// Wait for the DOM to load before dispatching a message to the app extension's Swift code.
document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("CheckIfBatteryPowered");
});

safari.self.addEventListener("message", messageHandler);

function messageHandler(event) {
    if (event.name === "OnBatteryPower") {
        deanimate(document.images);
    }
}

function freeze_gif(i) {
    var c = document.createElement('canvas');
    var w = c.width = i.width;
    var h = c.height = i.height;
    c.getContext('2d').drawImage(i, 0, 0, w, h);
    try {
        i.src = c.toDataURL(); // if possible, retain all css aspects
    } catch(e) { // cross-domain -- mimic original with all its tag attributes
        for (var j = 0, a; a = i.attributes[j]; j++) {
            c.setAttribute(a.name, a.value);
        }
        i.parentNode.replaceChild(c, i);
    }
}

function deanimate(images) {
    [].slice.call(images).forEach(function (image) {
        freeze_gif(image);
    });
}
