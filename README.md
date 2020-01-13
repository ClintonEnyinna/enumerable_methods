<h1 align="center">Enumerable Methods</h1>
<p>
  <img alt="Version" src="https://img.shields.io/badge/version-0.0.1-blue.svg?cacheSeconds=2592000" />
  <a href="#" target="_blank">
    <img alt="License: MIT " src="https://img.shields.io/badge/License-MIT -yellow.svg" />
  </a>
  <a href="https://twitter.com/ClintonEnyinna" target="_blank">
    <img alt="Twitter: ClintonEnyinna " src="https://img.shields.io/twitter/follow/ClintonEnyinna .svg?style=social" />
  </a>
</p>


## Description of the project 

>Rebuild of some of the most used Enumerable methods (each, each_with_index, select, all?, any?, none?, count, map, inject) practicing the use of "yield" and "Proc"

## Getting Started

You can download the enumerable.rb file and include it in your project.

## How to Use

**my_each:**
```
[12, 2, 4, 56, 34].my_each { |int| print (int * 2).to_s + " " } => 24 4 8 112 68
```

**my_each_with_index:**
```
hash = {}
%w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index } 
=> {"cat"=>0, "dog"=>1, "wombat"=>2}
```

**my_select:**
```
(1..10).my_select { |i| i % 3 == 0 } => [3, 6, 9]
```

**my_all?:**
```
[1, 2i, 3.14].my_all?(Numeric) => true
```

**my_any?:**
```
%w[ant bear cat].my_any?(/d/) => false
```

**my_none?:**
```
%w{ant bear cat}.my_none? { |word| word.length == 5 } => true
```

**my_count:**
```
[1, 2, 4, 2].my_count{ |x| x % 2 == 0 } => 3
```

**my_map:**
```
[3, 23, 45, 34].my_map { |i| i * i } => [9, 529, 2025, 1156]
```

**my_inject:**
```
(5..10).my_inject(1) { |product, n| product * n } => 151200
```

### Prerequisites

Ruby needs to be installed.

## Built with
* [Ruby](https://www.ruby-lang.org/en/) - Programming language used
* [VS Code](https://code.visualstudio.com/) - The code editor used
* [Ubuntu](https://www.linux.org/pages/download/) - Operating System


## 🏠 [Homepage](https://github.com/ClintonEnyinna/enumerable_methods)

<!-- CONTRIBUTING -->
## Contributing

Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

## Author

👤 **Clinton Enyinna**

* Twitter: [@enyinnaclinton ](https://twitter.com/ClintonEnyinna)
* Github: [@ClintonEnyinna](https://github.com/https:\/\/github.com\/ClintonEnyinna) 
