
window.addEventListener('flutter-first-frame', hideLoadingScreen);

function hideLoadingScreen() {
    document.getElementById('loading-view').style.display = 'none';
}