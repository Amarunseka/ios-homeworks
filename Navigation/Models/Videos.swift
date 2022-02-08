//
//  Videos.swift
//  Navigation
//
//  Created by Миша on 24.12.2021.
//

import Foundation

struct Video {
    let name: String
    let url: String
    let image: String
    let description: String
}


struct Videos {
    static let videosStorage: [Video] = [
        Video(name: "Матрица: Воскрешение", url: "https://www.youtube.com/watch?v=8qB8EGNOtr8", image: "MatrixResurrections",
              description: "  В двух реальностях Нео снова придется выбирать, следовать ли за белым кроликом. Выбор, пусть и иллюзорный, все еще остается единственным путем в Матрицу или из нее, что более опасно, чем когда-либо."),
        
        Video(name: "Довод", url: "https://www.youtube.com/watch?v=C6dZA-buNCw", image: "Tenet",
              description: "  После теракта в киевском оперном театре агент ЦРУ объединяется с британской разведкой, чтобы противостоять русскому олигарху, который сколотил состояние на торговле оружием. Для этого агенты используют инверсию времени — технологию будущего, позволяющую времени идти вспять."),
        
        Video(name: "Дюна", url: "https://www.youtube.com/watch?v=DOlTmIhEsg0", image: "Dune",
              description: "  Наследник знаменитого дома Атрейдесов Пол отправляется вместе с семьей на одну из самых опасных планет во Вселенной — Арракис. Здесь нет ничего, кроме песка, палящего солнца, гигантских чудовищ и основной причины межгалактических конфликтов — невероятно ценного ресурса, который называется меланж. В результате захвата власти Пол вынужден бежать и скрываться, и это становится началом его эпического путешествия. Враждебный мир Арракиса приготовил для него множество тяжелых испытаний, но только тот, кто готов взглянуть в глаза своему страху, достоин стать избранным."),
        
        Video(name: "Волк с Уолл-стрит", url: "https://www.youtube.com/watch?v=CHivqmutR0I", image: "WolfOfWallStreet",
              description: "  1987 год. Джордан Белфорт становится брокером в успешном инвестиционном банке. Вскоре банк закрывается после внезапного обвала индекса Доу-Джонса. По совету жены Терезы Джордан устраивается в небольшое заведение, занимающееся мелкими акциями. Его настойчивый стиль общения с клиентами и врождённая харизма быстро даёт свои плоды. Он знакомится с соседом по дому Донни, торговцем, который сразу находит общий язык с Джорданом и решает открыть с ним собственную фирму. В качестве сотрудников они нанимают нескольких друзей Белфорта, его отца Макса и называют компанию «Стрэттон Оукмонт». В свободное от работы время Джордан прожигает жизнь: лавирует от одной вечеринки к другой, вступает в сексуальные отношения с проститутками, употребляет множество наркотических препаратов, в том числе кокаин и кваалюд. Однажды наступает момент, когда быстрым обогащением Белфорта начинает интересоваться агент ФБР."),
        
        Video(name: "Книга Илая", url: "https://www.youtube.com/watch?v=wFmsxEkJgFo",image: "BookOfEli",
              description: "  После мировой катастрофы Америка превратилась в выжженную пустыню. По бескрайним дорогам, кишащим бандами, враждующими между собой за воду и еду, странствует мудрый Илай. Однажды он прибывает в мрачные края, где когда-то была цветущая Калифорния, а теперь это сущий ад, где бесчинствует тиран Карнеги."),
        
        Video(name: "Легенда", url: "https://www.youtube.com/watch?v=k7izcLjrArc", image: "Legend",
              description: "   Фильм расскажет историю близнецов Реджи и Ронни Крэй, культовых фигур преступного мира Великобритании 1960-х. Братья возглавляли самую влиятельную бандитскую группировку Ист-Энда. В их послужном списке: вооруженные грабежи, рэкет, поджоги, покушения, убийства и собственный ночной клуб, куда доезжали даже голливудские знаменитости. Среди их жертв — криминальные авторитеты Джек МакВитти и Джордж Корнелл.")
    ]
}
