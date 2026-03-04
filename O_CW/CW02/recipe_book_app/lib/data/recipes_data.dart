import '../models/recipe.dart';

final List<Recipe> sampleRecipes = [
  Recipe(
    name: 'Spaghetti Carbonara',
    imagePath: 'assets/images/pasta.png',
    ingredients: [
      '400g spaghetti',
      '200g guanciale or pancetta',
      '4 large egg yolks + 2 whole eggs',
      '50g Pecorino Romano, grated',
      '50g Parmesan, grated',
      'Black pepper',
      'Salt',
    ],
    instructions:
        'Bring a large pot of salted water to boil. Cook spaghetti until al dente. Meanwhile, cut guanciale into strips and fry in a pan until crispy. Whisk egg yolks, whole eggs, cheeses, and pepper in a bowl. Drain pasta, reserving a cup of starchy water. Toss hot pasta with guanciale, remove from heat, add egg mixture and toss quickly. Add pasta water as needed for a silky sauce. Serve immediately with more cheese and pepper.',
  ),
  Recipe(
    name: 'Greek Salad',
    imagePath: 'assets/images/salad.png',
    ingredients: [
      '4 large tomatoes, chunked',
      '1 cucumber, sliced',
      '1 red onion, thinly sliced',
      '200g feta cheese, cubed',
      'Kalamata olives',
      'Extra virgin olive oil',
      'Red wine vinegar',
      'Dried oregano',
      'Salt and pepper',
    ],
    instructions:
        'Combine tomatoes, cucumber, and onion in a large bowl. Add olives and feta. Drizzle with olive oil and vinegar, sprinkle with oregano, salt, and pepper. Toss gently. Let sit 10 minutes before serving.',
  ),
  Recipe(
    name: 'Chicken Stir-Fry',
    imagePath: 'assets/images/stirfry.png',
    ingredients: [
      '500g chicken breast, sliced',
      '2 bell peppers, sliced',
      '1 head broccoli, florets',
      '3 tbsp soy sauce',
      '1 tbsp sesame oil',
      '2 cloves garlic, minced',
      '1 inch ginger, grated',
      'Vegetable oil',
      'Green onions for garnish',
    ],
    instructions:
        'Heat vegetable oil in a wok or large pan over high heat. Stir-fry chicken until cooked through; set aside. Add more oil, stir-fry garlic and ginger briefly, then add peppers and broccoli. Cook until tender-crisp. Return chicken, add soy sauce and sesame oil, toss. Garnish with green onions and serve with rice.',
  ),
  Recipe(
    name: 'Tomato Basil Soup',
    imagePath: 'assets/images/soup.png',
    ingredients: [
      '800g canned or fresh tomatoes',
      '1 onion, diced',
      '3 cloves garlic, minced',
      'Fresh basil leaves',
      '500ml vegetable or chicken stock',
      'Cream or coconut milk (optional)',
      'Olive oil',
      'Salt and pepper',
    ],
    instructions:
        'Sauté onion and garlic in olive oil until soft. Add tomatoes and stock, bring to a boil, then simmer 20 minutes. Add basil. Blend until smooth. Stir in cream if using. Season with salt and pepper. Serve with bread or grilled cheese.',
  ),
  Recipe(
    name: 'Chocolate Brownies',
    imagePath: 'assets/images/brownies.png',
    ingredients: [
      '200g dark chocolate',
      '150g butter',
      '250g sugar',
      '3 eggs',
      '100g flour',
      '30g cocoa powder',
      'Pinch of salt',
    ],
    instructions:
        'Melt chocolate and butter together. Beat in sugar and eggs. Fold in flour, cocoa, and salt. Pour into a lined 20cm tin. Bake at 180°C for 25–30 minutes until set at the edges but slightly soft in the centre. Cool before cutting.',
  ),
];
