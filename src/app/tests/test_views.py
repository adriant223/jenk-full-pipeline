def test_home(client):
    resp = client.get("/")

    assert resp.status_code == 200
    assert b"Python" in resp.data
print("Test API 1/3 home succeded!")

def test_page_content(client):
    resp = client.get("/")

    assert resp.status_code == 200
    assert b"Coleman" in resp.data
print("Test API 2/3 page_content succeded!")

def test_info(client):
    resp = client.get("/info")

    assert resp.status_code == 200
    assert b"Hostname" in resp.data

print("Test API 3/3 info succeded!")