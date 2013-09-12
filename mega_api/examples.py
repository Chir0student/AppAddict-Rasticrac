from mega import Mega


def test():
    """
    Enter your account details to begin
    comment/uncomment lines to test various parts of the API
    see readme.md for more information
    """

    #user details
    email = 'your@email.com'
    password = 'password'

    mega = Mega()
    #mega = Mega({'verbose': True})  # verbose option for print output

    # login
    m = mega.login(email, password)

    # get user details
    details = m.get_user()
    print(details)

    # get account files
    files = m.get_files()

    # get account disk quota in MB
    print(m.get_quota())
    # get account storage space
    print(m.get_storage_space())

    # example iterate over files
    for file in files:
        print(files[file])

    # upload file
    print(m.upload('examples.py'))

    # search for a file in account
    file = m.find('examples.py')

    if file:
        # get public link
        link = m.get_link(file)
        print(link)

        # download file. by file object or url
        print m.download(file, '/tmp')
        #m.download_url(link)

        #delete or destroy file. by id or url
        print(m.delete(file[0]))
        #print(m.destroy(file[0]))
        #print(m.delete_url(link))
        #print(m.destroy_url(link))

    # empty trash
    print(m.empty_trash())

if __name__ == '__main__':
    test()