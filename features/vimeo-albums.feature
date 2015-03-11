@vcr
Feature: Vimeo albums

  @announce-stdout
  Scenario: Generate YAML for a Vimeo album
    Given a file named "_sources/vimeo" with:
    """
    https://vimeo.com/album/3296736
    """
    When I successfully run `purdie fetch`
    Then a file named "_data/vimeo.yaml" should exist
    And the file "_data/vimeo.yaml" should contain:
    """
    ---
    - title: Safety On Board
      id: 111356018
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    - title: Trapped In Hawaii
      id: 110133117
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    - title: Discotheque Metamorphosis
      id: 110132671
      license: Attribution-NonCommercial-ShareAlike
      license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
    """
