@vcr
Feature: Vimeo

  Scenario: Generate Vimeo YAML
    Given a file named "_sources/vimeo" with:
    """
    https://vimeo.com/117102891
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/vimeo.yaml" should exist
    And the file "_data/vimeo.yaml" should contain:
    """
    - title: Bernard
      id: 117102891
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    """
