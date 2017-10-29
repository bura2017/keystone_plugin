import requests
import unittest

class TestKeystone(unittest.TestCase):
    host = 'http://localhost:8001'
    def test_version(self):
        res = requests.get(self.host + '/v2.0')
        self.assertEqual(res.status_code, 200)
        print(res.headers)

    def test_create_tenant(self):
        body = {
            'tenant' : {
                'name' : 'admin'
            }
        }
        res = requests.post(self.host + '/v2.0/tenants', data = body)
        self.assertEqual(res.status_code, 200)

        enc = res.encoding
        self.tenant_id = enc['tenant']['id']

    def test_create_user(self):
        body = {
            "user": {
                "name": "admin",
                "tenantId": self.tenant_id,
                "password": "tester",
                "email": "some@email.com"
            }
        }
        res = requests.post(self.host + '/v2.0/users', data = body)
        self.assertEqual(res.status_code, 200)

        enc = res.encoding
        self.assertTrue(enc['user']['enabled'])

        self.user_id = enc['user']['id']

    def test_user_info(self):
        res = requests.get(self.host + '/v2.0/users/:' + self.user_id)
        self.assertEqual(res.status_code, 200)

    def test_receive_token(self):
        body = {
            "auth": {
                "passwordCredentials": {
                    "username": "admin",
                    "password": "tester"
                },
                "tenantName": "admin"
            }
        }
        res = requests.post(self.host + '/v2.0/tokens', data = body)
        self.assertEqual(res.status_code, 200)

    def test_delete_user(self):
        res = requests.delete(self.host + '/v2.0/users/:' + self.user_id)
        self.assertEqual(res.status_code, 200)

    def test_delete_tenant(self):
        res = requests.delete(self.host + '/v2.0/tenants/:' + self.tenant_id)
        self.assertEqual(res.status_code, 200)