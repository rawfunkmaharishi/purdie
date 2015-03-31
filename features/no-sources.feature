@vcr
Feature: Handle no _sources directory

  Scenario: Handle no _sources directory
    When I successfully run `purdie fetch`
    Then the stderr should contain "No data sources specified"
  #  And the exit status should be 1
