# Manual Deployment
Instructions to deploy the code in the Udacity environment.

Enable vim in deployment environment (optional)
```
set -o vi
```

Download the code from git
```
git clone --branch proto https://pguardati@github.com/pguardati/data-modelling-template.git
```
(insert the git password)

Access the cloned directory
```
cd data-modelling-template
```

Update code and deploy src files into the `workspace`
```
git pull
rm -rf ../src
cp -r src doc ../
```

Once no additional changes are needed, 
leave the `src` folder in the workspace and
remove the cloned directory
```
cd ..
rm -r data-modelling-template
``` 