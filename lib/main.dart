// Lab 6: Managing State in Flutter
// Abdusamad Nigmatov
// 220063

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ============================================================================
// SECTION 1: Understanding the Concept of State in Flutter
// ============================================================================

// Task 1 (Solution Included): StaticProfileCard and InteractiveProfileCard
class StaticProfileCard extends StatelessWidget {
  const StaticProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('John Doe'),
        subtitle: Text('john.doe@email.com'),
      ),
    );
  }
}

class InteractiveProfileCard extends StatefulWidget {
  const InteractiveProfileCard({super.key});

  @override
  State<InteractiveProfileCard> createState() => _InteractiveProfileCardState();
}

class _InteractiveProfileCardState extends State<InteractiveProfileCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('Jane Smith'),
        subtitle: Text('jane.smith@email.com'),
      ),
    );
  }
}

// Task 2 (Easy): ProductCard
class ProductCard extends StatelessWidget {
  final String productName;
  final double price;

  const ProductCard({
    super.key,
    required this.productName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(productName),
        trailing: Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Task 3 (Easy): LikeButton (non-interactive)
class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _isLiked ? Icons.favorite : Icons.favorite_border,
      color: _isLiked ? Colors.red : Colors.grey,
      size: 32,
    );
  }
}

// Task 4 (Medium): LikeButton (interactive)
class InteractiveLikeButton extends StatefulWidget {
  const InteractiveLikeButton({super.key});

  @override
  State<InteractiveLikeButton> createState() => _InteractiveLikeButtonState();
}

class _InteractiveLikeButtonState extends State<InteractiveLikeButton> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : Colors.grey,
        size: 32,
      ),
    );
  }
}

// Task 5 (Medium): UserNameInput
class UserNameInput extends StatefulWidget {
  const UserNameInput({super.key});

  @override
  State<UserNameInput> createState() => _UserNameInputState();
}

class _UserNameInputState extends State<UserNameInput> {
  String _userName = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _userName = value;
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Current value: $_userName',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 2: Utilizing setState for Simple State Management
// ============================================================================

// Task 1 (Solution Included): CounterPage
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('setState Counter')),
      body: Center(
        child: Text(
          'Count: $_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Task 2 (Easy): CounterPage with decrement
class CounterPageWithDecrement extends StatefulWidget {
  const CounterPageWithDecrement({super.key});

  @override
  State<CounterPageWithDecrement> createState() => _CounterPageWithDecrementState();
}

class _CounterPageWithDecrementState extends State<CounterPageWithDecrement> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter with Decrement')),
      body: Center(
        child: Text(
          'Count: $_counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _decrementCounter,
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _incrementCounter,
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// Task 3 (Easy): Visibility Toggle
class VisibilityToggle extends StatefulWidget {
  const VisibilityToggle({super.key});

  @override
  State<VisibilityToggle> createState() => _VisibilityToggleState();
}

class _VisibilityToggleState extends State<VisibilityToggle> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visibility Toggle')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isVisible)
              const Text(
                'This text is visible!',
                style: TextStyle(fontSize: 24),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleVisibility,
              child: Text(_isVisible ? 'Hide Text' : 'Show Text'),
            ),
          ],
        ),
      ),
    );
  }
}

// Task 4 (Medium): Todo List
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<String> _items = [];
  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _items.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addItem,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Task 5 (Medium): Color Box
class ColorBoxPage extends StatefulWidget {
  const ColorBoxPage({super.key});

  @override
  State<ColorBoxPage> createState() => _ColorBoxPageState();
}

class _ColorBoxPageState extends State<ColorBoxPage> {
  Color _boxColor = Colors.grey;

  void _changeColor(Color color) {
    setState(() {
      _boxColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Box')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: _boxColor,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _changeColor(Colors.red),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Red'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _changeColor(Colors.green),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Green'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _changeColor(Colors.blue),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Blue'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 3: Lifting State Up
// ============================================================================

// Task 1 (Solution Included): SwitchManager
class SwitchManager extends StatefulWidget {
  const SwitchManager({super.key});

  @override
  State<SwitchManager> createState() => _SwitchManagerState();
}

class _SwitchManagerState extends State<SwitchManager> {
  bool _isActive = false;

  void _handleSwitchChanged(bool newValue) {
    setState(() {
      _isActive = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lifting State Up')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('The Switch is: ${_isActive ? "ON" : "OFF"}'),
          const SizedBox(height: 20),
          InteractiveSwitch(
            isActive: _isActive,
            onChanged: _handleSwitchChanged,
          ),
        ],
      ),
    );
  }
}

class InteractiveSwitch extends StatelessWidget {
  final bool isActive;
  final ValueChanged<bool> onChanged;

  const InteractiveSwitch({
    super.key,
    required this.isActive,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isActive,
      onChanged: onChanged,
    );
  }
}

// Task 2 (Easy): Greeting
class GreetingParent extends StatefulWidget {
  const GreetingParent({super.key});

  @override
  State<GreetingParent> createState() => _GreetingParentState();
}

class _GreetingParentState extends State<GreetingParent> {
  String _name = 'Guest';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Greeting')),
      body: Center(
        child: Greeting(name: _name),
      ),
    );
  }
}

class Greeting extends StatelessWidget {
  final String name;

  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, $name',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

// Task 3 (Medium): TemperatureConverter
class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  State<TemperatureConverter> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  double _celsius = 0.0;

  void _updateCelsius(String value) {
    setState(() {
      _celsius = double.tryParse(value) ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Temperature Converter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CelsiusInput(onChanged: _updateCelsius),
            const SizedBox(height: 20),
            FahrenheitDisplay(celsius: _celsius),
          ],
        ),
      ),
    );
  }
}

class CelsiusInput extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CelsiusInput({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Celsius',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      ),
    );
  }
}

class FahrenheitDisplay extends StatelessWidget {
  final double celsius;

  const FahrenheitDisplay({super.key, required this.celsius});

  double _convertToFahrenheit() {
    return celsius * 9 / 5 + 32;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Fahrenheit: ${_convertToFahrenheit().toStringAsFixed(2)}°F',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

// Task 4 (Medium): Survey App
class SurveyApp extends StatefulWidget {
  const SurveyApp({super.key});

  @override
  State<SurveyApp> createState() => _SurveyAppState();
}

class _SurveyAppState extends State<SurveyApp> {
  double _satisfaction = 5.0;

  void _updateSatisfaction(double value) {
    setState(() {
      _satisfaction = value;
    });
  }

  String _getMessage() {
    if (_satisfaction < 3) {
      return 'Awful';
    } else if (_satisfaction < 7) {
      return 'Okay';
    } else {
      return 'Great!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Satisfaction Survey')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getMessage(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30),
            Slider(
              value: _satisfaction,
              min: 0,
              max: 10,
              divisions: 10,
              label: _satisfaction.toStringAsFixed(1),
              onChanged: _updateSatisfaction,
            ),
            Text(
              'Satisfaction: ${_satisfaction.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// Task 5 (Medium): Prop Drilling Example
class Grandparent extends StatefulWidget {
  const Grandparent({super.key});

  @override
  State<Grandparent> createState() => _GrandparentState();
}

class _GrandparentState extends State<Grandparent> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prop Drilling Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Parent(
              counter: _counter,
              onIncrement: _incrementCounter,
            ),
          ],
        ),
      ),
    );
  }
}

class Parent extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;

  const Parent({
    super.key,
    required this.counter,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Child(
      counter: counter,
      onIncrement: onIncrement,
    );
  }
}

class Child extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;

  const Child({
    super.key,
    required this.counter,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onIncrement,
      child: Text('Increment (Current: $counter)'),
    );
  }
}

// ============================================================================
// SECTION 4: Advanced State Management with Provider
// ============================================================================

// Task 1 (Solution Included): CounterModel
class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Counter')),
      body: Center(
        child: Consumer<CounterModel>(
          builder: (context, counter, child) => Text(
            'Count: ${counter.count}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterModel>(context, listen: false).increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Task 2 (Easy): UserModel
class UserModel extends ChangeNotifier {
  String _username = 'Guest';
  String get username => _username;

  void changeToAdmin() {
    _username = 'Admin';
    notifyListeners();
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Model')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UserModel>(
              builder: (context, user, child) => Text(
                'Username: ${user.username}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserModel>(context, listen: false).changeToAdmin();
              },
              child: const Text('Change to Admin'),
            ),
          ],
        ),
      ),
    );
  }
}

// Task 3 (Easy): Extended CounterModel
class ExtendedCounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }
}

class ExtendedCounterScreen extends StatelessWidget {
  const ExtendedCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extended Counter')),
      body: Center(
        child: Consumer<ExtendedCounterModel>(
          builder: (context, counter, child) => Text(
            'Count: ${counter.count}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Provider.of<ExtendedCounterModel>(context, listen: false).reset();
            },
            heroTag: 'reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Provider.of<ExtendedCounterModel>(context, listen: false).decrement();
            },
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Provider.of<ExtendedCounterModel>(context, listen: false).increment();
            },
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// Task 4 (Medium): ThemeModel
class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme Switcher')),
      body: Center(
        child: Consumer<ThemeModel>(
          builder: (context, theme, child) => Switch(
            value: theme.isDarkMode,
            onChanged: (_) => theme.toggleTheme(),
          ),
        ),
      ),
    );
  }
}

// Task 5 (Medium): TodoListModel
class TodoListModel extends ChangeNotifier {
  final List<String> _tasks = [];
  List<String> get tasks => List.unmodifiable(_tasks);

  void addTask(String task) {
    if (task.isNotEmpty) {
      _tasks.add(task);
      notifyListeners();
    }
  }

  void removeTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }
}

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List with Provider')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter task',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      Provider.of<TodoListModel>(context, listen: false).addTask(value);
                      controller.clear();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<TodoListModel>(context, listen: false).addTask(controller.text);
                    controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoListModel>(
              builder: (context, todoList, child) {
                return ListView.builder(
                  itemCount: todoList.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(todoList.tasks[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          Provider.of<TodoListModel>(context, listen: false).removeTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5: Optional Section - Practical Scenarios & Refactoring
// ============================================================================

// Task 1 (Solution Included): UserModel for Profile
class ProfileUserModel extends ChangeNotifier {
  String _name = 'Alice';
  String get name => _name;

  void changeName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileUserModel>();
    return Text(
      'User: ${user.name}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<ProfileUserModel>().changeName('Bob');
      },
      child: const Text('Change Name'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ProfileHeader(),
            SizedBox(height: 20),
            EditButton(),
          ],
        ),
      ),
    );
  }
}

// Task 2 (Easy): FavoriteModel
class FavoriteModel extends ChangeNotifier {
  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void toggle() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
      builder: (context, favorite, child) => IconButton(
        icon: Icon(
          favorite.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: favorite.isFavorite ? Colors.red : Colors.grey,
        ),
        onPressed: () {
          context.read<FavoriteModel>().toggle();
        },
      ),
    );
  }
}

// Task 3 (Medium): CartModel
class CartModel extends ChangeNotifier {
  final List<String> _items = [];
  List<String> get items => List.unmodifiable(_items);

  void addItem(String item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  final List<String> products = const [
    'Product 1',
    'Product 2',
    'Product 3',
    'Product 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            trailing: ElevatedButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addItem(products[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${products[index]} added to cart')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          );
        },
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shopping Cart')),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Cart is empty'));
          }
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.items[index]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false).removeItem(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Task 4 (Medium): AsyncDataModel
class AsyncDataModel extends ChangeNotifier {
  bool _isLoading = false;
  String _data = '';

  bool get isLoading => _isLoading;
  String get data => _data;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _data = 'Fetched user data: John Doe';
    _isLoading = false;
    notifyListeners();
  }
}

class AsyncDataScreen extends StatelessWidget {
  const AsyncDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Async Data')),
      body: Center(
        child: Consumer<AsyncDataModel>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return const CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.data.isEmpty ? 'No data' : model.data,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<AsyncDataModel>(context, listen: false).fetchData();
                  },
                  child: const Text('Fetch Data'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Task 5 (Medium): SettingsModel
class SettingsModel extends ChangeNotifier {
  bool _notificationsEnabled = true;
  double _volumeLevel = 0.5;

  bool get notificationsEnabled => _notificationsEnabled;
  double get volumeLevel => _volumeLevel;

  void setNotificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notifyListeners();
  }

  void setVolumeLevel(double value) {
    _volumeLevel = value;
    notifyListeners();
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<SettingsModel>(
        builder: (context, settings, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Notifications', style: TextStyle(fontSize: 18)),
                    Switch(
                      value: settings.notificationsEnabled,
                      onChanged: (value) {
                        Provider.of<SettingsModel>(context, listen: false)
                            .setNotificationsEnabled(value);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text('Volume Level', style: TextStyle(fontSize: 18)),
                Slider(
                  value: settings.volumeLevel,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  label: '${(settings.volumeLevel * 100).toInt()}%',
                  onChanged: (value) {
                    Provider.of<SettingsModel>(context, listen: false).setVolumeLevel(value);
                  },
                ),
                Text(
                  'Volume: ${(settings.volumeLevel * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ============================================================================
// MAIN APP
// ============================================================================

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ExtendedCounterModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => TodoListModel()),
        ChangeNotifierProvider(create: (_) => ProfileUserModel()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => AsyncDataModel()),
        ChangeNotifierProvider(create: (_) => SettingsModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, theme, child) {
          return MaterialApp(
            title: 'Lab 6: State Management',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 6: State Management')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Section 1: Understanding State',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildButton(context, 'Static Profile Card', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Static Profile Card')),
                body: Center(child: StaticProfileCard()),
              )),
            );
          }),
          _buildButton(context, 'Interactive Profile Card', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Interactive Profile Card')),
                body: Center(child: InteractiveProfileCard()),
              )),
            );
          }),
          _buildButton(context, 'Product Card', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Product Card')),
                body: Center(child: ProductCard(productName: 'Laptop', price: 999.99)),
              )),
            );
          }),
          _buildButton(context, 'Like Button', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Like Button')),
                body: Center(child: LikeButton()),
              )),
            );
          }),
          _buildButton(context, 'Interactive Like Button', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Interactive Like Button')),
                body: Center(child: InteractiveLikeButton()),
              )),
            );
          }),
          _buildButton(context, 'User Name Input', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('User Name Input')),
                body: UserNameInput(),
              )),
            );
          }),
          const Divider(),
          const Text(
            'Section 2: setState',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildButton(context, 'Counter Page', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CounterPage()));
          }),
          _buildButton(context, 'Counter with Decrement', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CounterPageWithDecrement()));
          }),
          _buildButton(context, 'Visibility Toggle', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const VisibilityToggle()));
          }),
          _buildButton(context, 'Todo List', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoListPage()));
          }),
          _buildButton(context, 'Color Box', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ColorBoxPage()));
          }),
          const Divider(),
          const Text(
            'Section 3: Lifting State Up',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildButton(context, 'Switch Manager', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SwitchManager()));
          }),
          _buildButton(context, 'Greeting', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const GreetingParent()));
          }),
          _buildButton(context, 'Temperature Converter', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TemperatureConverter()));
          }),
          _buildButton(context, 'Survey App', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SurveyApp()));
          }),
          _buildButton(context, 'Prop Drilling Example', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Grandparent()));
          }),
          const Divider(),
          const Text(
            'Section 4: Provider',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildButton(context, 'Provider Counter', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const CounterScreen()));
          }),
          _buildButton(context, 'User Model', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const UserScreen()));
          }),
          _buildButton(context, 'Extended Counter', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ExtendedCounterScreen()));
          }),
          _buildButton(context, 'Theme Switcher', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ThemeScreen()));
          }),
          _buildButton(context, 'Todo List with Provider', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const TodoListScreen()));
          }),
          const Divider(),
          const Text(
            'Section 5: Practical Scenarios',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          _buildButton(context, 'Profile Screen', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
          }),
          _buildButton(context, 'Favorite Button', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Scaffold(
                appBar: AppBar(title: Text('Favorite Button')),
                body: Center(child: FavoriteButton()),
              )),
            );
          }),
          _buildButton(context, 'Shopping Cart', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductScreen()));
          }),
          _buildButton(context, 'Async Data', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AsyncDataScreen()));
          }),
          _buildButton(context, 'Settings', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
