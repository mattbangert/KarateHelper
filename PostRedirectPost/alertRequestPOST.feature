@ignore
Feature: POST handler to handle the POST -> GET redirect issue
 Workaround for https://github.com/intuit/karate/issues/668
  Background:
    * url baseUrl

  Scenario: get redirects can be disabled
    * configure followRedirects = false
    Given request __arg
    When method POST
    Then status 302
    * def location = responseHeaders['Location'][0]
    Given url location
    And request __arg
    Then method POST
