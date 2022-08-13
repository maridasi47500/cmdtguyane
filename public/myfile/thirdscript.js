      function myactions1(){
   
                              var runsec = document.createElement("script");
    runsec.setAttribute("src", "/myfile/jquery.navgoco.min.js"); 
    document.body.appendChild(runsec);


            
                                document.write("<script type='application/x-suppress'>");
      jQuery('.sf-with-ul').click(function(){
    window.location=jQuery(this).attr("href");
});
                                };
                                myactions1();
