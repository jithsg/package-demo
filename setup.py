from setuptools import setup, find_packages

# Define the setup function
setup(
    # Name of your package
    name='my_package',

    # Version number of your package
    version='0.1.0',

    # Your name or the name of your organization
    author='Your Name',

    # Your email address
    author_email='your_email@example.com',

    # A short description of your package
    description='A brief description of what your package does',

    install_requires=['numpy'],
    # Find all packages (any directory with an __init__.py file)
    packages= find_packages(),
    
)
