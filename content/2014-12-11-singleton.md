Title: Singleton
date: 2014-12-11
comments: true
slug: python
---

<!-- PELICAN_BEGIN_SUMMARY -->
Some guys in stackoverflow said that most of people who think they need singleton are actually never need it.
But that's what they said. Sometime you really need singleton to ensure that there is only one instance of your object.
<!-- PELICAN_END_SUMMARY -->

Today I want to share how to make singleton pattern in Python. This approach doesn't use decorator, just a class and a function.

Please take a look at these codes:

Singleton.py
------------

```
class Singleton:
    __instance = None
    def __init__( self, name):
        self.name = name
        if Singleton.__instance:
            raise Singleton.__instance
        Singleton.__instance = self

def make_instance(name = '' ):
    try:
        instance = Singleton(name)
    except Singleton, s:
        instance = s
    return instance
```

Different from a common way, we don't initialize an object like this:

```
my_obj = Singleton("my name")
```

but, we initialize an object this way:

```
my_obj = make_instance("my name")
```

`make_instance` will check whether the `__instance` in `Singleton` is exists or not.
`__instance` is a class property. It is shared through all instance of `Singleton`.
This can ensure that we will only have one single instance of `Singleton`.

Let's try this by making 3 different files

a.py
----
```
from singleton import make_instance

a = make_instance('agumon')
```

b.py
----
```
from singleton import make_instance

b = make_instance('birdramon')
```

c.py
----
```
from singleton import make_instance
from a import a
from b import b

c = make_instance('chakumon')

print(a,b,c)
print(a.name, b.name, c.name)
```

If you run `c.py`, you will get this result:

```
<singleton.Singleton instance at 0xb71e806c> <singleton.Singleton instance at 0xb71e806c> <singleton.Singleton instance at 0xb71e806c>
agumon agumon agumon
```

It's works, `a`,`b`, and `c` is exactly refer to the same object.
If you really want to change the `name` property, you can do this:

```
c.name = 'chakumon'
```

and it will affect `a` and `b` as well since they refer to the same object as `c`.

Okay, great. Singleton works. But why do you need something tricky like this?
In my case, I have a problem when trying to split several sql-alchemy models into different file and ensure that they have
the same `engine`.

You might not need it in near time. There are special cases that can be solved with singleton.
Right now, you can have a peace in your mind that singleton approach in Python is possible.

