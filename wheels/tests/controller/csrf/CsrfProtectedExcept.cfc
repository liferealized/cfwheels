component extends="wheelsMapping.Test" {
  include "csrf_setup.cfm";

  function test_csrf_protection_with_valid_authenticityToken_on_PATCH_request() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="update", authenticityToken=CSRFGenerateToken() };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    loc.controller.$processAction("update", loc.params);
    assert('loc.controller.response() eq "Update ran."');
  }

  function test_csrf_protection_with_no_authenticityToken_on_PATCH_request() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="update" };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    try {
      loc.controller.$processAction("update", loc.params);
      fail("Wheels.InvalidAuthenticityToken error did not occur.");
    }
    catch (any e) {
      assert("e.Type is 'Wheels.InvalidAuthenticityToken'");
    }
  }

  function test_csrf_protection_with_invalid_authenticityToken_on_PATCH_request() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="update", authenticityToken="#CSRFGenerateToken()#1" };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    try {
      loc.controller.$processAction("update", loc.params);
      fail("Wheels.InvalidAuthenticityToken error did not occur.");
    }
    catch (any e) {
      assert("e.Type is 'Wheels.InvalidAuthenticityToken'");
    }
  }

  function test_skipped_csrf_protection_on_PATCH_request_with_valid_authenticityToken() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="show", authenticityToken=CSRFGenerateToken() };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    loc.controller.$processAction("update", loc.params);
    assert('loc.controller.response() eq "Show ran."');
  }

  function test_skipped_csrf_protection_on_PATCH_request_with_no_authenticityToken() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="show" };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    loc.controller.$processAction("update", loc.params);
    assert('loc.controller.response() eq "Show ran."');
  }

  function test_skipped_csrf_protection_on_PATCH_request_with_invalid_authenticityToken() {
    request.cgi.request_method = "PATCH";
    loc.params = { controller="csrfProtectedExcept", action="show", authenticityToken="#CSRFGenerateToken()#1" };
    loc.controller = controller("csrfProtectedExcept", loc.params);

    loc.controller.$processAction("update", loc.params);
    assert('loc.controller.response() eq "Show ran."');
  }
}