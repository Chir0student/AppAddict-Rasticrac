# Mega.py
[![Build Status](https://travis-ci.org/richardasaurus/mega.py.png?branch=master)](https://travis-ci.org/richardasaurus/mega.py)
[![Downloads](https://pypip.in/d/mega.py/badge.png)](https://crate.io/packages/mega.py/)

Python library for the Mega.co.nz API, currently supporting:
 - login
 - uploading
 - downloading
 - deleting
 - searching
 - sharing
 - renaming
 - moving files

This is a work in progress, further functionality coming shortly.

For more detailed information see API_INFO.md

## How To Use

### Install mega.py package
```python
#Run the following command, or run setup from the latest github source
sudo pip install mega.py
```
### Import mega.py
```python
from mega import Mega
```
### Create an instance of Mega.py
```python
mega = Mega()
# add the verbose option for print output on some functions
mega = Mega({'verbose': True})
```
### Login to Mega
```python
m = mega.login(email, password)
# login using a temporary anonymous account
m = mega.login()
```
### Get user details
```python
details = m.get_user()
```
### Get account balance (Pro accounts only)
```python
balance = m.get_balance()
```
### Get account disk quota
```python
quota = m.get_quota()
```
### Get account storage space
```python
# specify unit output kilo, mega, gig, else bytes will output
space = m.get_storage_space(kilo=True)
```
### Get account files
```python
files = m.get_files()
```
### Upload a file, and get its public link
```python
file = m.upload('myfile.doc')
m.get_upload_link(file)
# see mega.py for destination and filename options
```
### Upload a file to a destination folder
```python
folder = m.find('my_mega_folder')
m.upload('myfile.doc', folder[0])
```

### Download a file from URL or file obj, optionally specify destination folder
```python
file = m.find('myfile.doc')
m.download(file)
m.download_url('https://mega.co.nz/#!utYjgSTQ!OM4U3V5v_W4N5edSo0wolg1D5H0fwSrLD3oLnLuS9pc')
m.download(file, '/home/john-smith/Desktop')
# specify optional download filename (download_url() supports this also)
m.download(file, '/home/john-smith/Desktop', 'myfile.zip')
```
### Import a file from URL, optionally specify destination folder
```python
m.import_public_url('https://mega.co.nz/#!utYjgSTQ!OM4U3V5v_W4N5edSo0wolg1D5H0fwSrLD3oLnLuS9pc')
folder_node = m.find('Documents')[1]
m.import_public_url('https://mega.co.nz/#!utYjgSTQ!OM4U3V5v_W4N5edSo0wolg1D5H0fwSrLD3oLnLuS9pc', dest_node=folder_node)
```
### Create a folder
```python
m.create_folder('new_folder')
```
### Rename a file or a folder
```python
file = m.find('myfile.doc')
m.rename(file, 'my_file.doc')
```
### Moving a file or a folder into another folder
```python
file = m.find('myfile.doc')
folder = m.find('myfolder')
m.move(file[0], folder)
```
### Search account for a file, and get its public link
```python
file = m.find('myfile.doc')
m.get_link(file)
```
### Trash or destroy a file from URL or its ID
```python
m.delete(file[0])
m.delete_url('https://mega.co.nz/#!utYjgSTQ!OM4U3V5v_W4N5edSo0wolg1D5H0fwSrLD3oLnLuS9pc')

m.destroy(file[0])
m.destroy_url('https://mega.co.nz/#!utYjgSTQ!OM4U3V5v_W4N5edSo0wolg1D5H0fwSrLD3oLnLuS9pc')

files = m.find('myfile.doc')
if files:
    m.delete(files[0])
```
### Add/remove contacts
```python
m.add_contact('test@email.com')
m.remove_contact('test@email.com')
```

## Requirements

    1. Python2.7+
    2. Python requests (>0.10) - python-requests.org
    3. PyCrypto - dlitz.net/software/pycrypto/

## Tests

    Test .py files can be found in tests.py, run these to ensure Mega.py is working 100%.

## Contribute

    Feel free to pull the source and make changes and additions.

    Learn about the API at Mega.co.nz, more documentation coming shortly.
    - https://mega.co.nz/#developers



