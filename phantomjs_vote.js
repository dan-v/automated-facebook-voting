var page = require('webpage').create();
page.settings.userAgent = 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3';
page.open('http://woobox.com/<actual_content_url>/vote/for/<id_to_vote_for>', function () {

    page.render('before_vote.png');
    
    page.evaluate(function () {
      if(! document.getElementsByClassName("top votebutton_<id_to_vote_for> votebutton voted").length){
        action(<id_to_vote_for>);
      }
    });
    
    page.render('after_vote.png');
    
    var t = 10,
    interval = setInterval(function(){
        if ( t > 0 ) {
            console.log(t--);
        } else {
            console.log("Done Voting!");
            phantom.exit();
        }
    }, 1000);
});
