$(document).on("turbolinks:load", function () {
  const player = new Plyr('#player');
});
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "https://connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v3.2&appId=316228302413165&autoLogAppEvents=1"
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
