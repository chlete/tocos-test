import unittest
from tocoscredits import app

class TestApp(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()

    def test_get_user(self):
        response = self.app.get('/user')
        data = response.get_json()

        self.assertEqual(response.status_code, 200)
        self.assertIsInstance(data, list)
        self.assertEqual(len(data), 3)

        # Verify the content of the first user
        self.assertIn('username', data[0])
        self.assertEqual(data[0]['username'], 'alex')
        self.assertIn('tocos', data[0])
        self.assertEqual(data[0]['tocos'], 30)

        # Verify the content of the second user
        self.assertIn('username', data[1])
        self.assertEqual(data[1]['username'], 'ben')
        self.assertIn('tocos', data[1])
        self.assertEqual(data[1]['tocos'], 50)

        # Verify the content of the third user
        self.assertIn('username', data[2])
        self.assertEqual(data[2]['username'], 'charles')
        self.assertIn('tocos', data[2])
        self.assertEqual(data[2]['tocos'], 366)

if __name__ == '__main__':
    unittest.main()
