from setuptools import setup

setup(
    name="network_manager_ui",
    version="0.0.0",
    py_modules=["network_manager_ui"],
    entry_points = {
        'console_scripts': [
            "network_manager_ui = network_manager_ui:main"
        ]
    }
)