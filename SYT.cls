%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TMR Class File
% Author: Marina Rose "Mars" Geldard
% http://github.com/TheMartianLife/Resume

% Available for others' use under:
% 

% Last Updated: 04/05/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Class identification & inheritance
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{SYT}

% Paper dimensions
\LoadClass[11pt, a4paper]{article}
\RequirePackage[left=1in, top=0.6in, right=1in, bottom=0.5in]{geometry}

% Gain functionality from third party packages
\RequirePackage{fancyhdr}
\RequirePackage{parskip}
\RequirePackage{pdfpages}
\RequirePackage{fontawesome}
\RequirePackage{import}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{environ}
\RequirePackage{xparse}
\RequirePackage[explicit]{titlesec}
\RequirePackage{tikz}
\RequirePackage{etoolbox}
\RequirePackage{hyperref}\hypersetup{hidelinks}
\RequirePackage{titlesec}
\RequirePackage{CJKutf8}

% Set up document to start
\renewcommand{\headrulewidth}{0pt}
% Get details from author input
\newcommand{\fullname}[1]{\def\@fullname{#1}}
\newcommand{\documenttitle}[1]{\def\@documenttitle{#1}}
\newcommand{\greeting}[1]{\def\@greeting{#1}}
\newcommand{\farewell}[1]{\def\@farewell{#1}}
\newcommand{\recipient}[2]{\def\@recipientname{#1}\def\@recipientaddress{#2}}

% from awesome-cv
\DeclareOption{alternative}{
  \def\@alternative{alternate}
}

\ProcessOptions

\newcommand{\mailSymbol}{\faEnvelope}
\newcommand{\mailSymbolO}{\faEnvelopeO}
\newcommand{\locationSymbol}{\faMapMarker}
\newcommand{\infoSymbol}{\faInfo}
\newcommand{\homeSymbol}{\faLink}
\newcommand{\weiboSymbol}{\faWeibo}
\newcommand{\linkedinSymbol}{\faLinkedin}
\newcommand{\mobileSymbol}{\faMobilePhone}
\newcommand{\githubSymbol}{\faGithub}
\newcommand\link[2]{\href{#1}{#2}}
\newcommand\user[3]{{\LARGE #1 \textbf{#2} \LARGE #3}}
\newcommand{\socialtext}[2]{\mbox{{#1}\hspace{0.5em}#2\hspace{1em}}}
\newcommand{\sociallink}[3]{\mbox{{#1}\hspace{0.5em}\link{#2}{#3}\hspace{1em}}}
\newcommand*{\name}[3]{\def\@firstname{#1}\def\@lastname{#2}\def\@chinesename{#3}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\chinesename}[1]{\def\@chinesename{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}
\newcommand*{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand*{\address}[1]{\socialtext{\locationSymbol}{#1}}
\newcommand*{\infos}[1]{\socialtext{\infoSymbol}{#1}}
\newcommand*{\homepage}[1]{\sociallink{\homeSymbol}{http://#1}{#1}}
\newcommand{\socialinfo}[1]{\def\@socialinfo{#1}}
\newcommand*{\github}[1]{\sociallink{\githubSymbol}{https://www.github.com/#1}{github.com/#1}}           % Github icon + URL
\newcommand*{\email}[1]{\sociallink{\mailSymbol}{mailto:#1}{#1}}
\newcommand*{\emailO}[1]{\sociallink{\mailSymbolO}{mailto:#1}{#1}}
\newcommand*\smartphone[1]{\socialtext{\mobileSymbol}{#1}}

\newcommand\resumetitle[1]{
  \ifundef{\@
  	}{
	 \par{
	 	 \bigskip\center{\Large \textsc{#1}}\par
	 }
	 \bigskip
  }{
   % \color{accentcolor}\textsc{\large{#1}}\color{black}
	 \par{
	 	\bigskip\center{\Large \textsc{#1}}\par
	 }
	 \bigskip
  }
}




% Define styles for text
\setlength{\parskip}{0.8em}
\newcommand{\pipe}{\ifhmode\hspace{1em}\fi}
\newcommand{\foottext}[1]{\textsc{\footnotesize#1}}
\renewcommand{\baselinestretch}{1.2}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE HIGH-LEVEL DOCUMENT ENVIRONMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Command to hide coverletter in PDF ouput
\newif\ifcoverletter
\coverlettertrue

\newcommand{\hidecoverletter}{
	\coverletterfalse
}

% Runs pre- & post-commands for coverletter doc
\NewEnviron{coverletter}{
	\ifcoverletter
		% Construct topmatter
		\tmrheader
		\hrulefill
		\tmrtitle
		\thispagestyle{empty}

		\BODY

		% Construct bottom matter
		\tmrclosing
	\fi
}

% Runs pre- & post-commands for resume doc
\newenvironment{resume}{
	\clearpage
	\setcounter{page}{1}
	\pagestyle{fancy}

	% Construct top & bottom matter
	\makecvheader
	\tmrfooter
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE LOWER-LEVEL TOP & BOTTOM MATTER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 
\newcommand*{\makecvheader}{
	\ifundef{\@alternative}{
		\ifundef{\@photodiameter}{
			\begin{minipage}{\linewidth}    	      	
		}{
			\begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}        	
		}
		\user{\@firstname}{\@lastname}{\@chinesename} \vspace*{0.3cm}\\				 	
				\small{\@socialinfo}
			\end{minipage}  
		\ifdef{\@photodiameter}{
			\begin{minipage}{\@photodiameter}
				\begin{tikzpicture}%
				\node[circle, text=white, minimum size=2.5cm,
				path picture={\node at (path picture bounding box.center){
						\includegraphics[width=2.5cm]{\@photo}
					};
				}]{ };
				\end{tikzpicture}				
			\end{minipage}
		}{}
	    \resumetitle{\@tagline}
	}{
	    \ifundef{\@photodiameter}{
			\begin{minipage}{\linewidth}     	
	    }{
			\begin{minipage} {\dimexpr\linewidth-\@photodiameter-2em}    	
	    }
		\user{\@firstname}{\@lastname} {\@chinesename} \vspace*{0.3cm}\\
				\resumetitle{\@tagline}
				\smallskip\\
				\small{\@socialinfo}
			\end{minipage}  	    
		\ifdef{\@photodiameter}{
			\begin{minipage}{\@photodiameter}
				\begin{tikzpicture}%
				\node[text=white, minimum width=2.8cm, minimum height=2.8cm, %minimum size=2.8cm,
				path picture={\node at (path picture bounding box.center){
						\includegraphics[width=2.5cm]{\@photo}
					};
				}]{ };
				\end{tikzpicture}			
			\end{minipage} 			
		}{}
		\bigskip
	}
}


% Makes page footer
\newif\iffullfooter

\newcommand{\fullfooter}{
	\fullfootertrue
}

\newcommand{\tmrfooter}{

	% Empty header fields
	\fancyhead{}

	\iffullfooter
		% Set left field to today's date
		\lfoot{\foottext{\today}}

		% Set middle field to name, document type
		\cfoot{\foottext{\@fullname~\textbar~R\'esum\'e}}	

		% Set right field to page number
		\rfoot{\foottext{\thepage}}	
	\fi
}


% Makes recipient section from details & dates letter
\newcommand{\tmrtitle}{ 
	\textbf{\@recipientname}\hfill\textit{\today}\\
	\@recipientaddress \\\\\\
	\@greeting,
}


% Signs off letter
\newcommand{\tmrclosing}{
	\vspace{10mm}\filbreak
	\@farewell, \\\\ \textbf{\@fullname} \\\\
	\textit{Attached: R\'esum\'e	}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE LOWER-LEVEL DOCUMENT COMPONENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Remove section numbers
\renewcommand{\@seccntformat}[1]{}
\renewcommand{\@seccntformat}[2]{}

% Style headings
\titleformat{\section}{\Large\bfseries}{}{0pt}{#1\hrulefill}
\titleformat{\subsection}{\filbreak\small\scshape}{}{0pt}{#1}

% Change spacing around headings
\titlespacing*{\section}{0pt}{4pt}{0pt}
\titlespacing*{\subsection}{0pt}{0pt}{0pt}

% 4-field double row entries
\newcommand{\entry}[4]{\filbreak\normalsize\textbf{#1}\hfill#3\\\textit{#2}\hfill\textit{#4}\small}

% Single row entries
\NewDocumentCommand{\row}{m o m m}{%
	\par\filbreak\parbox{0.06\textwidth}{\raggedright#1}%
	\parbox{0.71\textwidth}{~~\IfNoValueF{#2}{\textbf{\foottext#2}~}#3}%
	\parbox{0.23\textwidth}{~~\raggedleft\textit{#4}}\par%
}

% Fake bulletpoint
\newcommand{\point}[1]{$\bullet$~~\parbox[t]{0.98\textwidth}{\raggedright#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REDACT PRIVATE INFORMATION IF PUBLIC VERSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\ifpublicversion

\newcommand{\public}{
	\publicversiontrue
}

\newcommand{\private}[1]{
	\ifpublicversion[redacted]\else#1\fi
}

\newcommand{\reference}[1]{
	\ifpublicversion\else\includepdf[pages=-]{#1}\fi
}
