$(function() {
  const logoUrl = $(".plugin-vid-hidden").data('logo-vid')
  $("#login-form").append(`
    <div class="plugin-vid-container">
      <div class="or-text">OR</div>
      <div class="sso-vareal-id">
        <img class="google-icon" width="20px" src="/plugin_assets/redmine_vareal_id/images/logo.png?1691568219">
        <span class="title">Login with Vareal ID</span>
      </div>
    </div>
    `)

  $(document).on("click", ".sso-vareal-id", function(e){
    const callbackUrl = $(".plugin-vid-hidden").data("login-url");
    window.location.href = callbackUrl
  })
});