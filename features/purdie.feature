Feature: Purdie

  Scenario: Generate YAML
    Given a file named "_sources/sounds.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/sounds.yaml" should exist
    And the file "_data/sounds.yaml" should contain:
    """
    - title:       Hexaflexagon
      id:          193008299
      location:    Islington Academy
      date:        '2015-02-18'
      license:     Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    """
