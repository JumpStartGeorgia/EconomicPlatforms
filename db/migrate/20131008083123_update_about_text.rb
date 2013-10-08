# encoding: UTF-8
class UpdateAboutText < ActiveRecord::Migration
  def up
    Page.transaction do
      page = Page.find_by_name('about')
      locales = ['en', 'ka', 'am', 'az', 'ru']
      
      locales.each_with_index do |locale, i|
        trans = PageTranslation.where(:locale => locale, :page_id => page.id)
        if trans.present?
          if i == 0
            trans.first.description = '<h2>Presidential Elections – 2013</h2>
<br />
    <p> 
    Starting from 2013 a new project Involvement of ethnic minorities of Georgia in assessing economic and social programs of the election-participant political parties has started. The Project is implemented by Economic Policy Research Center (EPRC) with the support of the US Embassy in Georgia Small Grants Program. The main aim of the project is to improve the transparency and efficiency of the Georgian democratic system by providing the general public and ethnic minorities with a timely and professional evaluation of electoral promises, policy proposals and views on policy put forward by the leading Georgian parties in the run up to May 2014 (for local elections) and partially for 2013 Presidential elections.   
    </p>

    <p>
    As a result the project will establish a program based pre-election campaigning culture; inform Georgian and non-Georgian speaking population regarding parties’ economic and social programs; establish political debating culture in the regions populated by ethnic minorities.
    </p>

    <p> 
    The project’s target qualified Presidential Candidates are:
    </p>
    <ul class="standard">
    <li>
    Giorgi Margvelashvili - Coalition "Georgian Dream"
    </li>
    <li>
    David Bakradze - United National Movement
    </li>
    <li>
    Giorgi Targamadze – Christian-Democratic Movement
    </li>
    <li>
    Nino Burjanadze - Democratic Movement – "United Georgia"
    </li>
    <li>
    Sergo Javakhadze  – Movement – "Justice for Georgia"
    </li>
    </ul>
<br /><br />
    <h2>Parliamentary Elections - 2012</h2>
<br />' + trans.first.description
          else
            trans.first.description = '<h2>საპრეზიდენტო არჩევნები - 2013</h2>
<br />
    <p> 
    2013 წლის აგვისტოდან დაიწყო ახალი პროექტი - ეთნიკური უმცირესობების მონაწილეობის გაძლიერება პოლიტიკური პარტიების წინასაარჩევნო სოციალურ-ეკონომოკური პროგრამების შეფასების პროცესში. პროექტს ახორციელებს ეკონომიკური პოლიტიკის კვლევის ცენტრი (EPRC), საქართველოში აშშ საელჩოს მცირე გრანტების პროგრამის ფარგლებში.
    </p>
    <p> 
    პროექტის ძირითად მიზანს წარმოადგენს საქართველოს დემოკრატიული სისტემის გამჭვირვალობისა და ეფექტურობის გაუმჯობესება, საზოგადოებისთვის და ეთნიკური უმცირესობებისთვის დროული და პროფესიული შეფასების მიწოდება წინასაარჩევნო დაპირებების და შეთავაზებების, ასევე წამყვანი პოლიტიკური პარტიების მიერ წამოწეული პოლიტიკური შეხედულებების შესახებ (2014 წლის ადგილობრივ არჩევნებში) და ნაწილობრივ 2013 წლის საპრეზიდენტო არჩევნებში.
    </p>
    <p> 
    პროექტის ამოცანაა ხელი შეეწყოს ქვეყანაში მრავალპარტიული დემოკრატიის განვითარებას, პოლიტიკური დისკუსიის კულტურის დამკვიდრებას რეგიონებში და ეთნიკური უმცირესობების წარმომადგენლების აქტიურ მონაწილეობას ამ პროცესებში. 
    </p>
    <p> 
    პროექტში მონაწილე კვალიფიციური საპრეზიდენტო კანდიდატები არიან:
    </p>
    <ul class="standard"> 
    <li>
    გიორგი მარგველაშვილი - კოალიცია „ქართული ოცნება“
    </li>
    <li>
    დავით ბაქრაძე - ერთიანი ნაციონალური მოძრაობა
    </li>
    <li>
    გიორგი თარგამაძე - ქრისტიან-დემოკრატიული მოძრაობა
    </li>
    <li>
    ნინო ბურჯანაძე - დემოკრატიული მოძრაობა  - „ერთიანი საქართველო“
    </li>
    <li>
    სერგო ჯავახაძე - მოძრაობა „სამართლიანი საქართველოსთვის“
    </li>
    </ul>
<br /><br />
    <h2>საპარლამენტო არჩევნები - 2012</h2>
    <br />' + trans.first.description
          end
          trans.first.save
        end
      end

    end  
  end

  def down
    Page.transaction do
      page = Page.find_by_name('about')
      locales = ['en', 'ka', 'am', 'az', 'ru']
      
      locales.each_with_index do |locale, i|
        trans = PageTranslation.where(:locale => locale, :page_id => page.id)
        if trans.present?
          if i == 0
            trans.first.description = '<p>The project is implemented jointly by four Georgian think tanks:</p>
<ul class="standard">
<li>Economic Policy Research Center (EPRC)</li>
<li>ISET Policy Institute</li>
<li>Liberal Academy Tbilisi (LAT)</li>
<li>Transparency International Georgia (TI Georgia)</li>
</ul>
<p>with the financial support from the Policy, Advocacy, and Civil Society Development in Georgia (G-PAC) program of USAID/ East-West Management Institute (EWMI).</p>
<p>The main aim of this project is to improve the transparency and efficacy of the Georgian democratic system by providing the general public with a timely and professional evaluation of electoral promises, policy proposals and views on policy put forward by the leading Georgian parties in the run up to October 2012 elections. On the one hand, this would allow Georgian voters to make a better informed political choice. On the other hand, the project would help discipline parties in their communication with the media and general public. Ultimately, the project in face of this web-site will promote the development of multiparty democracy in Georgia and thus contribute to the strengthening of the state\'s key institutions.</p>
<p>The project’s target qualified political parties are:</p>
<ul class="standard">
<li>Christian Democratic Movement</li>
<li>Coalition “Georgian Dream”</li>
<li>Labor Party</li>
<li>National Democratic Party</li>
<li>New Rights’ Party</li>
<li>United National Movement.</li>
</ul>
<p>Specific objectives of the project are:</p>
<ul class="standard">
<li>Clarify the political parties’ positions on a comprehensive set of policy issues (agriculture, social programs, education, healthcare, macroeconomic issues). The web-site presents party views/statements for each policy issue, these views include official programs of the parties as well as various statements presented by representatives of the parties during their pre-election campaigns. The portal will be updated on a weekly basis to allow voters a dynamic view of how the parties update their positions in response to external events and/or campaign dynamics.</li>
<li>Provide expert review of political platforms and statements on policy. This will be done regularly in the run up to elections.</li>
<li>Organize presentations and debates for each political party involved to enable them present their pre- election economic platforms to the media, international organizations, experts, and through the media to general public. In total 6 presentations will be held for each party involved. As a result, parties’ economic platforms and statements will be judged by independent experts and presented under policy briefs. </li>
</ul>
<br />

<h3>Collaborating Partners</h3>
<br />
<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://eprc.ge/index.php?a=main&pid=7&lang=eng" target="_blank"><img src="/system/page_files/files/1/original/EPRC.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://eprc.ge/index.php?a=main&pid=7&lang=eng" target="_blank">Economic Policy Research Center</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.ei-lat.ge/about-us.html" target="_blank"><img src="/system/page_files/files/1/original/EILAT.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.ei-lat.ge/about-us.html" target="_blank">European Initiative Liberal Academy Tbilisi</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://iset-pi.ge/" target="_blank"><img src="/system/page_files/files/1/original/ISET.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://iset.ge/index.php?article_id=2" target="_blank">ISET Policy Institute</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.transparency.ge/en" target="_blank"><img src="/system/page_files/files/1/original/TI-georgia.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.transparency.ge/en" target="_blank">Transparency International Georgia</a>
</p>
</div>
</div>

<h3>Donors</h3>
<br />
<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.ewmi-gpac.org/" target="_blank"><img src="/system/page_files/files/1/original/usaid_e-w_logo.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.ewmi-gpac.org/" target="_blank"><ul><li>USAID</li><li>East West Management Institute</li><li>Policy, Advocacy, and Civil Society Development in Georgia</li></a>
</p>
</div>
</div>

<p>The project is implemented in the framework of The East-West Management Institute’s (EWMI) Policy, Advocacy, and Civil Society Development in Georgia (G-PAC) Program, funded by United States Agency for International Development (USAID).</p>

<p>The project is made possible by the generous support of the American people through the USAID. The content is the responsibility of the implementing organizations and does not necessarily reflect the view of USAID, the United States Government, or EWMI.</p>

</div>'
          else
            trans.first.description = '<p>პროექტი ხორციელდება ოთხი გაერთიანებული ქართული კვლევითი ინსტიტუსის მიერ:</p>
<ul class="standard">
<li>ეკონომიკური პოლიტიკის კვლევითი ცენტრი (EPRC)</li>
<li>ISET პოლიტიკური ინსტიტუიტი</li>
<li>თბილისის ლიბერალური აკადემია (LAT)</li>
<li>საერთაშორისო გამჭირვალობა საქართველოში (TI Georgia)</li>
</ul>
<p>პროექტი ხორციელდება აღმოსავლეთ-დასავლეთის მართვის ინსტიტუტის (EWMI) პროგრამის „საქართველოში საჯარო პოლიტიკის, ადვოკატირებისა და სამოქალაქო საზოგადოების განვითარება“ (G-PAC) ფარგლებში, რომელიც ამერიკის შეერთებული შტატების საერთაშორისო განვითარების სააგენტოს (USAID) დაფინასებით ხორციელდება. პროექტის მთავარ მიზანს წარმოადგენს პროფესიული შეფასება საქართველოს პოლიტიკური პარტიების 2012 წლის წინა საარჩევნო განცხადებებისა და დაპირებების, რაც თავის მხრივ ხელს შეუწყობს გამჭვირვალობასა და ქართულ დემოკრატიულ სისტემას. ერთის მხრივ ეს ხელს შეუწყობს საქართველოს მოსახლეობას გააკეთოს არჩევანი ინფორმაციაზე დაყრდნობით, ხოლო მეორეს მხრივ დაეხმარება პოლიტიკურ პარტიებს მედიასთან და საზოგადოებასთან კომუნიკაციაში.რაც მთავარია ვებ საიტის ფორმატში ეს პროექტი ხელს შეუწყობს მრავალპარტიულ დემოკრატიას საქართველოში და ამავდროულად გააძლიერებს სახელმწიფოს მთავარ ინსტიტუტებს.</p>

<p>პროექტის მიზნობრივი და კვალიფიციური პარტიები:</p>
<ul class="standard">
<li>ქრისტიან-დემოკრატიული მოძრაობა</li>
<li>კოალიცია “ქართული ოცნება”</li>
<li>ლეიბორისტული პარტია</li>
<li>ეროვნულ-დემოკრატიული პარტია</li> 
<li>ახალი მემარჯვენეები</li>
<li>ერთიანი ნაციონალური მოძრაობა</li>
</ul>

<p>პროექტის ძირითადი მიზნები:</p>
<ul class="standard">
<li>პოლიტიკური პარტიების პოზიციისა და პროგრამის ამომწურავი ინფორმაცია (სოფლის მეორნეობა, სოციალური უზრუნველყოფა, განათლება, ჯანდაცვა, მაკროეკონომიკული საკითხები). ვებ გვერდი წარმოადგენს თითოეული პარტიის ხედვასა და განცხადებას ყველა საკითხთან დაკავშირებით, ყოველივე ეს მოიცავს არა მხოლოდ ოფიციალურ პროგრამას არამედ, პარტიის სხვადასხვა წარმომადგენლების მიერ წინა საარჩევნო განცხადებებს ამა თუ იმ საკითხთან დაკავშირებით. პორტალი ახლდება ყოველკვირეულად როგორ პოლიტიკური პარტიები აახლებენ  პოზიციებსა თუ განცხადებებს.<li>
<li>წარმოვადგინოთ ექპერტების მიმოხილვა პოლიტიკურ პლატფორმებსა და განცხადებებზე. ეს ინფორმაცია რეგულარულად იქნება არჩევნებამდე.</li>
<li>პრეზენტაციებისა და დებატების ორგანიზება ყველა პოლიტიკური პარტიისათვის რათა მათ შეძლონ გააცნონ წინა საარჩევნო ეკონომიკური პლატფორმები მედიას,საერთაშორი ორგანიზაციებსა და საზოგადოებას. საერთო ჯამში გაიმართება 6 პრეზენტაცია სადაც ჩაერთვება ყველა პოლიტიკური პარტია. შედეგად პოლიტიკური პარტიების განცხადებები განხილული იქნება დამოუკიდებელ ექქპერტთა მიერ.</li>
</ul>
<br />

<h3>პარტნიორები</h3>
<br />
<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://eprc.ge/index.php?a=main&pid=7&lang=eng" target="_blank"><img src="/system/page_files/files/1/original/EPRC.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://eprc.ge/index.php?a=main&pid=7&lang=eng" target="_blank">Economic Policy Research Center</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.ei-lat.ge/about-us.html" target="_blank"><img src="/system/page_files/files/1/original/EILAT.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.ei-lat.ge/about-us.html" target="_blank">European Initiative Liberal Academy Tbilisi</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://iset-pi.ge/" target="_blank"><img src="/system/page_files/files/1/original/ISET.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://iset.ge/index.php?article_id=2" target="_blank">ISET Policy Institute</a>
</p>
</div>
</div>

<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.transparency.ge/en" target="_blank"><img src="/system/page_files/files/1/original/TI-georgia.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.transparency.ge/en" target="_blank">Transparency International Georgia</a>
</p>
</div>
</div>

<h3>დონორები</h3>
<br />
<div class="row" style="margin-bottom: 2em;">
<div class="span6" style="text-align: center;">
<a href="http://www.ewmi-gpac.org/" target="_blank"><img src="/system/page_files/files/1/original/usaid_e-w_logo.jpg" />
</div>
<div class="span5" style="text-align: center;">
<p>
<br />
<a href="http://www.ewmi-gpac.org/" target="_blank"><ul><li>USAID</li><li>East West Management Institute</li><li>Policy, Advocacy, and Civil Society Development in Georgia</li></a>
</p>
</div>
</div>

<p>პროექტი ხორციელდება აღმოსავლეთ-დასავლეთის მართვის ინსტიტუტის (EWMI) პროგრამის „საქართველოში საჯარო  პოლიტიკის, ადვოკატირებისა და სამოქალაქო  საზოგადოების განვითარება“ (G-PAC) ფარგლებში, რომელიც ამერიკის შეერთებული შტატების საერთაშორისო განვითარების სააგენტოს  (USAID) დაფინასებით ხორციელდება.</p>

<p>პროექტის განხორციელება შესაძლებელი გახდა ამერიკის ხალხის გულისხმიერი მხარდაჭერის შედეგად, ამერიკის შეერთებული შტატების საერთაშორისო განვითარების სააგენტოს  (USAID) დაფინასებით. პროექტის ფარგლებში მომზადებული მასალების შინაარსზე მთლიანად პასუხისმგებელი არიან პროექტის განმახორციელებელი ორგანიზაციები და ეს შინაარსი შეიძლება არ გამოხატავდეს USAID-ის, ამერიკის შეერთებული შტატების მთავრობის ან EWMI-ს შეხედულებებს.</p>

</div>'
          end
          trans.first.save
        end
      end

    end    
  end
end
