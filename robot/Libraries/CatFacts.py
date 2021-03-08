"""
Description         function for Retrieve data for Cats facts
"""

import requests
import socket


def http_send(method, url, parameters=None, headers=None):
    """Send HTTP GET/ request and use try-except block for any error handling
    :param method: an HTTP method, e.g. "GET".
    :param url: a url used to send the request.
    :param data: a string of data sent (if any).
    :param headers: header to be sent with the request.
    :return: an HTTP response instance.
    """
    try:
        if method == "GET":
            response = requests.get(url, params=parameters, headers=headers)
    except (requests.exceptions.ConnectionError, socket.gaierror) as err:
        print(("Could not send %s %s due to %s" % (method, url, err)))
    return response


class CatFacts(object):

    def __init__(self):
        self.base_url = "https://cat-fact.herokuapp.com/"

    def get_facts(self,animal_type='cat',amount=1):
        """Retrieve facts about the animals by providing animal_type and amount as the input parameter
            :param animal_type: a string of data sent
            :param amount: an integer value maximum limit of 500
            :return response: The response from the request
        """
        req_url = '{}facts/random'.format(self.base_url)
        parameters = {'animal_type': animal_type, 'amount': amount}
        response = http_send("GET", req_url, parameters, headers={'Accept': 'application/json'})
        return response

    def get_facts_by_id(self,factid):
        """Retrieve facts about the animals by providing factid
                    :param factid: a string of data sent
                    :return response: The response from the request
                """
        req_url = '{}facts/{}'.format(self.base_url, factid)
        response = http_send("GET", req_url, headers={'Accept': 'application/json'})
        return response

    def custom_call(self, url_end=""):
        """Perform a custom call with base url and any additions

        :param url_end: a string to be appended at the end of base URL
        :return response:  The response from the request
        """
        req_url = self.base_url + url_end
        response = http_send("GET", req_url, headers={'Accept': 'application/json'})
        return response

    def call_with_custom_headers(self, animal_type, amount, header):
        """Perform calls with default parameters and faulty headers

        :return response:  The response from the request
        """
        print(header)
        req_url = '{}facts/random'.format(self.base_url)
        parameters = {'animal_type': animal_type, 'amount': amount}
        response = http_send("GET", req_url, parameters, headers=header)
        return response
