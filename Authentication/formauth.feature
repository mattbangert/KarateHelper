@ignore
Feature: Authenticate the user
  This feature file is intended to be called by other feature files in the Background step.  Unless
  you need to use different variables for the authentication, consider using the Karate callonce
  command to call this feature.

  Example:
  * def authJson = read('classpath:resources/auth.json')
  * set authJson.baseUrl = baseUrl
  * set authJson.userName = userName
  * set authJson.password = password
  * def c = callonce read('classpath:authenticate.feature') authJson
  * cookies c.result

  Scenario: Authenticate the user to get the session cookie information
    Given url __arg.baseUrl
    And path authEndpointPath
    And form field j_username = __arg.userName
    And form field j_password = __arg.password
    When method post
    Then status 200
    * def keys = []
    * def vals = []
    * def idxs = []
    * def fun = function(x, y, i){ keys.add(x); vals.add(y); idxs.add(i) }
    * def map = responseCookies
    * eval karate.forEach(map, fun)
    * def parser =
    """
     function(obj) {
      var jsonData = new Object();
      for (value in obj) {
        jsonData[obj[value].name] = obj[value].value
      }
      return jsonData
     }
    """
    * def result = parser(vals)
