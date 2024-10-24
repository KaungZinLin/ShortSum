//
//  OfTheDayViewModel.swift
//  StudyIO
//
//  Created by Kaung Zin Lin on 03/08/2024.
//

import Foundation

class OfTheDayViewModel: ObservableObject {
    struct Quote: Identifiable {
        let id = UUID()
        let text: String
        let author: String
        let picture: String
    }
    
    struct Joke: Identifiable {
        let id = UUID()
        let text: String
    }
    
    let quotes: [Quote] = [
        Quote(text: "End is not the end if fact E.N.D. Means “Efforts Never Dies.", author: "Dr. A.P.J. Abdul Kalam", picture: "AbdulKalam"),
        Quote(text: "Education is the most powerful weapon you can use to change the world.", author: "Nelson Mandela", picture: "NelsonMandela"),
        Quote(text: "A person who never made a mistake never tried anything new.", author: "Albert Einstein", picture: "AlbertEinstein"),
        Quote(text: "There are plenty of difficult obstacles in your path. Don’t allow yourself to become one of them.", author: "Ralph Marston", picture: "RalphMarston"),
        Quote(text: "Only I can change my life. No one can do it for me.", author: "Carol Burnett", picture: "CarolBurnett"),
        Quote(text: "I think I can. I know I can.", author: "Jennifer Wittwer", picture: "Unknown"),
        Quote(text: "Learning is never done without error, and defeat", author: "Vladimir Lenin", picture: "VladmirLenin"),
        Quote(text: "You must be the change you wish to see in the world.", author: "Mahatma Gandhi", picture: "MahatmaGandhi"),
        Quote(text: "There is no substitute for hard work.", author: "Thomas Alva Edison", picture: "ThomasEdison"),
        Quote(text: "Don’t wait for the opportunity. Create it.", author: "George Bernard Shaw", picture: "GeorgeBernardShaw"),
        Quote(text: "Success is the sum of all efforts, repeated day-in & day-out.", author: "R. Collier", picture: "Unknown"),
        Quote(text: "Failure will never overtake me if my determination to succeed is strong enough.", author: "Og Mandino", picture: "OgMandino"),
        Quote(text: "Self-belief and hard work will always earn you success.", author: "Virat Kohli", picture: "ViratKohli"),
        Quote(text: "I am indeed a king because I know how to rule myself.", author: "Pietro Aretino", picture: "PietroAretino"),
        Quote(text: "Your time is limited, so don’t waste it living someone else’s life. Don’t be trapped by dogma which is living with the results of other people’s thinking.", author: "Steve Jobs", picture: "SteveJobs"),
        Quote(text: "When you reach the end of your rope, tie a knot in it and hang on.", author: "Franklin D. Roosevelt", picture: "FranklinRoosevelt"),
        Quote(text: "Always remember that you are absolutely unique. Just like everyone else.", author: "Margaret Mead", picture: "Unknown"),
        Quote(text: "Tell me and I forget. Teach me and I remember. Involve me, and I learn.", author: "Benjamin Franklin", picture: "BenjaminFranklin"),
        Quote(text: "The best and most beautiful things in the world cannot be seen or even touched – they must be felt with the heart.", author: "Helen Keller", picture: "HelenKeller"),
        Quote(text: "In the end, it’s not the years in your life that count. It’s the life in your years.", author: "Abraham Lincoln", picture: "AbrahamLincoln"),
        Quote(text: "Every day is a second chance.", author: "Unknown", picture: "Unknown"),
        Quote(text: "I never dreamed about success. I worked for it.", author: "Estée Lauder", picture: "Unknown"),
        Quote(text: "Wake up with determination and go to bed with satisfaction.", author: "Unknown", picture: "Unknown"),
        Quote(text: "If you get tired, learn to rest not to quit.", author: "Banksy", picture: "Unknown"),
        Quote(text: "The more you give away the happier you become.", author: "Unknown", picture: "Unknown"),
        Quote(text: "Make each day your masterpiece.", author: "John Wooden", picture: "JohnWooden"),
        Quote(text: "Learn from yesterday, live for today, hope for tomorrow. The important thing is not to stop questioning.", author: "Albert Einstein", picture: "AlbertEinstein"),
        Quote(text: "Opportunity does not happen, You need to create them.", author: "Unknown", picture: "Unknown"),
        Quote(text: "Live as if you were to die tomorrow. Learn as if you were to live forever.", author: "Mahatma Gandhi", picture: "Unknown"),
        Quote(text: "I have not failed. I’ve just found 10,000 ways that won’t work.", author: "Thomas Edison", picture: "ThomasEdison"),
        Quote(text: "Failure is another steppingstone to greatness.", author: "Oprah Winfrey", picture: "Unknown"),
        Quote(text: "I believe every human has a finite number of heartbeats. I don’t intend to waste any of mine.", author: "Neil Armstrong", picture: "Unknown"),
        Quote(text: "The biggest risk is not taking any risk… In a world that’s changing really quickly, the only strategy that is guaranteed to fail is not taking risks.", author: "Mark Zuckerberg", picture: "MarkZuckerberg"),
        Quote(text: "The best revenge is massive success.", author: "Frank Sinatra", picture: "Unknown"),
        Quote(text: "Nothing great ever achieved without enthusiasm.", author: "Ralph Waldo Emerson", picture: "Unknown"),
        Quote(text: "You cannot change your future, but you can change your habits, and surely your habits will change your future.", author: "A.P.J. Abdul Kalam", picture: "AbdulKalam"),
        Quote(text: "Doubt kills more dreams than failure ever will.", author: "Karim Seddiki", picture: "KarimSeddiki"),
        Quote(text: "You want to have a future where you’re expecting things to be better, not one where you’re expecting things to be worse.", author: "Elon Musk", picture: "ElonMusk"),
        Quote(text: "An ounce of patience is worth more than tons of preaching.", author: "Mahatma Gandhi", picture: "Unknown"),
        Quote(text: "Look at the sky. We are not alone. The whole universe is friendly to us and conspires only to those who dream and work.", author: "Unknown", picture: "Unknown")
    ]
    
    let jokes = [
        Joke(text: "What did one hat say to the other? You wait here — I'll go on ahead!"),
        Joke(text: "Why don't the circus lions eat the clowns? Because they taste funny!"),
        Joke(text: "What did the pirate say when he turned 80? 'Aye matey.'"),
        Joke(text: "Why did the chicken cross the playground? To get to the other slide!"),
        Joke(text: "Why did the actor fall through the floorboards? They were going through a stage!"),
        Joke(text: "Why did a scarecrow win a Nobel prize? He was outstanding in his field!"),
        Joke(text: "Why are peppers the best at archery? Because they habanero!"),
        Joke(text: "What did the duck say after she bought chapstick? Put it on my bill!"),
        Joke(text: "Why did an old man fall in a well? Because he couldn’t see that well!"),
        Joke(text: "What do you call a fake noodle? An impasta!"),
        Joke(text: "What did the three-legged dog say when he walked into a saloon? 'I’m looking for the man who shot my paw!'"),
        Joke(text: "How do you tell the difference between a bull and a cow? It is either one or the udder!"),
        Joke(text: "What’s red and smells like blue paint? Red paint!")
    ]
    
    var randomQuote: Quote {
        quotes.randomElement() ?? Quote(text: "No quote available", author: "Unknown", picture: "Unknown")
    }
    
    var randomJoke: Joke {
        jokes.randomElement() ?? Joke(text: "What did the mama cow say to the calf? It’s pasture bedtime!")
    }
}
