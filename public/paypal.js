function renderButton() {
  paypal.Button.render({
    env: 'sandbox',
    style: {
      label: 'checkout',
      size: 'responsive',
      shape: 'rect',
      color: 'blue'
    },
    commit: true,
    client: {
      sandbox: 'AQ37AUmyTsiUDWpJwneUkl8Aj6GcIJc_IMgK48henDoXrfLMmOUZEp-zskKot7OMzm5TY4xh17bz-aRL',
      production: 'AdMTUABdr8blUgWKQSsa5q5AuozSqpmbG2azgGzKfdzYEp1jY-3AJeAZuTY7Wzr3QXZhIGOCd1nT487K'
    },
    payment: function (actions) {
      var transactionsRaw = $("#transactions").val();
      console.log(transactionsRaw);
      return result = actions.payment.create(JSON.parse(transactionsRaw));
    },
    onAuthorize: function(data,actions) {
      return actions.payment.execute().then(function(payment){
        //payment complete
        //console.log(payment);
        var paymentStr = JSON.stringify({'payment':payment});
        $.ajax({
          url: $("#redirectURL").val(),
          data: paymentStr,
          type: 'PATCH',
          contentType: 'application/json',
          cache: false
        });
      });
    }
  }, '#btnPayNow');
}
