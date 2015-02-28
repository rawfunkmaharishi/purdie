Feature: Purdie

  Scenario: Generate YAML
    Given a file named "_sources/sounds.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/sounds.yaml" should exist
    
