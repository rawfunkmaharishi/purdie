Feature: Purdie

  Scenario: Generate YAML
    Given a file named "config/sounds.csv" with:
    """
    https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
    """
    When I successfully run `purdie fetch`
